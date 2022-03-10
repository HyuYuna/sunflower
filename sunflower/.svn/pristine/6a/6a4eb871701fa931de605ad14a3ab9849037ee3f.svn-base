package site.unp.cms.service.sys.impl;


import java.io.DataInputStream;
import java.io.File;
import java.io.InputStreamReader;
import java.lang.management.ManagementFactory;
import java.lang.management.OperatingSystemMXBean;
import java.lang.management.RuntimeMXBean;
import java.lang.reflect.Method;
import java.nio.charset.Charset;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.apache.commons.io.IOUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import site.unp.cms.service.sys.SysInfoService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.CommonServiceLink.LinkType;
import site.unp.core.annotation.UnpJsonView;
import site.unp.core.service.cs.impl.CommonServiceImpl;
import site.unp.core.util.WebUtil;

@CommonServiceDefinition(
	pageQueryData="menuNo,searchCnd,searchKwd,useAt"
)
@CommonServiceLink(desc="시스템정보", linkType=LinkType.BOS)
@Service
public class SysInfoServiceImpl extends CommonServiceImpl implements SysInfoService{

	protected Log log = LogFactory.getLog(this.getClass());
	private DecimalFormat df = new DecimalFormat("#.#", DecimalFormatSymbols.getInstance(Locale.ROOT));

	@UnpJsonView
	public void list(ParameterContext paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		model.addAttribute("systemInfo", this.getSystemInfo());
		model.addAttribute("jvmInfo", this.getJvmInfo());
		model.addAttribute("systemProperties", System.getProperties());
		model.addAttribute("hddInfo", this.getHddInfo());
	}

	public Map<String, Object> getSystemInfo() {
		Map<String, Object> info = new HashMap<String, Object>();

		OperatingSystemMXBean os = ManagementFactory.getOperatingSystemMXBean();
		info.put("name", os.getName());
		info.put("version", os.getVersion());
		info.put("arch", os.getArch());
		info.put("systemLoadAverage", os.getSystemLoadAverage());

		// com.sun.management.OperatingSystemMXBean
		addGetterIfAvaliable(os, "committedVirtualMemorySize", info);
		long freePhysicalMemorySize = addGetterIfAvaliable(os, "freePhysicalMemorySize", info);
		long freeSwapSpaceSize = addGetterIfAvaliable(os, "freeSwapSpaceSize", info);
		addGetterIfAvaliable(os, "processCpuTime", info);
		long totalPhysicalMemorySize = addGetterIfAvaliable(os, "totalPhysicalMemorySize", info);
		long totalSwapSpaceSize = addGetterIfAvaliable(os, "totalSwapSpaceSize", info);

		// com.sun.management.UnixOperatingSystemMXBean
		addGetterIfAvaliable(os, "openFileDescriptorCount", info);
		addGetterIfAvaliable(os, "maxFileDescriptorCount", info);

		long usedPhysicalMemorySize = totalPhysicalMemorySize - freePhysicalMemorySize;
		long usedSwapSpaceSize = totalSwapSpaceSize - freeSwapSpaceSize;
		double percentPhysicalMemorySize = (double)usedPhysicalMemorySize / (double)totalPhysicalMemorySize * 100;
		double percentSwapSpaceSize = (double)usedSwapSpaceSize / (double)totalSwapSpaceSize * 100;
		info.put("percentPhysicalMemorySize", df.format(percentPhysicalMemorySize));
		info.put("freePhysicalMemorySizeHR", humanReadableUnits(freePhysicalMemorySize, df));
		info.put("usedPhysicalMemorySizeHR", humanReadableUnits(usedPhysicalMemorySize, df));
		info.put("totalPhysicalMemorySizeHR", humanReadableUnits(totalPhysicalMemorySize, df));

		info.put("freeSwapSpaceSizeHR", humanReadableUnits(freeSwapSpaceSize, df));
		info.put("usedSwapSpaceSizeHR", humanReadableUnits(usedSwapSpaceSize, df));
		info.put("percentSwapSpaceSize", df.format(percentSwapSpaceSize));
		info.put("totalSwapSpaceSizeHR", humanReadableUnits(totalSwapSpaceSize, df));

		try {
			if (!os.getName().toLowerCase(Locale.ROOT).startsWith("windows")) {
				// Try some command line things
				info.put("uname", execute("uname -a"));
				info.put("uptime", execute("uptime"));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return info;
	}

	public Map<String, Object> getJvmInfo() {
		Map<String, Object> info = new HashMap<String, Object>();

		final String javaVersion = System.getProperty("java.specification.version", "unknown");
		final String javaVendor = System.getProperty("java.specification.vendor", "unknown");
		final String javaName = System.getProperty("java.specification.name", "unknown");
		final String jreVersion = System.getProperty("java.version", "unknown");
		final String jreVendor = System.getProperty("java.vendor", "unknown");
		final String vmVersion = System.getProperty("java.vm.version", "unknown");
		final String vmVendor = System.getProperty("java.vm.vendor", "unknown");
		final String vmName = System.getProperty("java.vm.name", "unknown");

		// Summary Info
		info.put("jvmVersion", jreVersion + " " + vmVersion);
		info.put("jvmName", jreVendor + " " + vmName);

		// details
		info.put("javaVendor", javaVendor);
		info.put("javaNname", javaName);
		info.put("javaVersion", javaVersion);
		info.put("jreVendor", jreVendor);
		info.put("jreVendor", jreVendor);
		info.put("vmVendor", vmVendor);
		info.put("vmName", vmName);
		info.put("vmVersion", vmVersion);

		Runtime runtime = Runtime.getRuntime();
		info.put("processors", runtime.availableProcessors());

		// not thread safe, but could be thread local
		long free = runtime.freeMemory();
		long max = runtime.maxMemory();
		long total = runtime.totalMemory();
		long used = total - free;
		double percentUsed = ((double) (used) / (double) total) * 100;
		info.put("rawFree", free);
		info.put("memFree", humanReadableUnits(free, df));
		info.put("rawTotal", total);
		info.put("memTotal", humanReadableUnits(total, df));
		info.put("rawMax", max);
		info.put("memMax", humanReadableUnits(max, df));
		info.put("rawUsed", used);
		info.put("memUsed", humanReadableUnits(used, df));
		info.put("rawUsed%", percentUsed);
		info.put("memUsedPercent", df.format(percentUsed));

		try {
			RuntimeMXBean mx = ManagementFactory.getRuntimeMXBean();
			info.put("jmxBootclasspath", mx.getBootClassPath());
			info.put("jmxClasspath", mx.getClassPath());

			info.put("jmxCommandLineArgs", mx.getInputArguments());

			info.put("jmxStartTime", new Date(mx.getStartTime()));
			info.put("jmxUpTimeMS", mx.getUptime());

		} catch (Exception e) {
			log.warn("Error getting JMX properties", e);
		}
		return info;
	}

	public List<ZValue> getHddInfo() {

		List<ZValue> list = new ArrayList<ZValue>();
		String  drive;
		int  totalSize, freeSize, useSize;

		File[] roots = File.listRoots();

		for (File root : roots) {
			ZValue vo = new ZValue();
			drive = root.getAbsolutePath();

			totalSize = (int)(root.getTotalSpace() / Math.pow(1024, 3));
			useSize = (int)(root.getUsableSpace() / Math.pow(1024, 3));
			freeSize = (int)(totalSize - useSize);

			vo.put("drive", drive);
			vo.put("totalSize", totalSize+ " GB");
			vo.put("useSize", useSize+ " GB");
			vo.put("freeSize", freeSize+ " GB");
			list.add(vo);
		}
		return list;
	}


	private long addGetterIfAvaliable(Object obj, String getter, Map<String, Object> info) {
		long result = 0;
		Object v = null;
		try {
			String n = Character.toUpperCase(getter.charAt(0)) + getter.substring(1);
			Method m = obj.getClass().getMethod("get" + n);
			m.setAccessible(true);
			v = m.invoke(obj, (Object[]) null);
			if (v != null) {
				info.put(getter, v);
			}
			result = Long.valueOf(v.toString()).longValue();
		} catch (Exception ex) {
		}
		return result;
	}

	private String execute(String cmd) {
		DataInputStream in = null;
		Process process = null;

		try {
			process = Runtime.getRuntime().exec(WebUtil.removeOSCmdRisk(cmd));
			in = new DataInputStream(process.getInputStream());
			// use default charset from locale here, because the command invoked
			// also uses the default locale:
			return IOUtils.toString(new InputStreamReader(in, Charset.defaultCharset()));
		} catch (Exception ex) {
			// ignore - log.warn("Error executing command", ex);
			return "(error executing: " + cmd + ")";
		} finally {
			if (process != null) {
				IOUtils.closeQuietly(process.getOutputStream());
				IOUtils.closeQuietly(process.getInputStream());
				IOUtils.closeQuietly(process.getErrorStream());
			}
		}
	}

	private static final long ONE_KB = 1024;
	private static final long ONE_MB = ONE_KB * ONE_KB;
	private static final long ONE_GB = ONE_KB * ONE_MB;

	private static String humanReadableUnits(long bytes, DecimalFormat df) {
		String newSizeAndUnits;

		if (bytes / ONE_GB > 0) {
			newSizeAndUnits = String.valueOf(df.format((float) bytes / ONE_GB)) + " GB";
		} else if (bytes / ONE_MB > 0) {
			newSizeAndUnits = String.valueOf(df.format((float) bytes / ONE_MB)) + " MB";
		} else if (bytes / ONE_KB > 0) {
			newSizeAndUnits = String.valueOf(df.format((float) bytes / ONE_KB)) + " KB";
		} else {
			newSizeAndUnits = String.valueOf(bytes) + " bytes";
		}

		return newSizeAndUnits;
	}

	public static void main(String[] args) throws Exception {
		System.out.println(new SysInfoServiceImpl().getSystemInfo());
	}
}
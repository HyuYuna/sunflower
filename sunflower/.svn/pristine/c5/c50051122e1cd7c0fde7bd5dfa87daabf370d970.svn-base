package site.unp.cms.web;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import site.unp.core.ZValue;
import site.unp.core.util.WebFactory;

@Controller
public class SmsController extends DefaultCommonControllerBase {

	@RequestMapping({"/{siteId}/system/sms/smsDirectSend"})
	public ModelMap smsDirectSend(HttpServletRequest request, HttpServletResponse response, @PathVariable String siteId, ModelMap model) throws Exception{
		ZValue param = WebFactory.getAttributes(request);
		
		/////////////////////////////////////////////////////////////////////////////////////
		
		String title = "해바라기시스템 문자발송";
		String message = param.getString("msg");		//필수입력
		String sender = param.getString("sphone");		//필수입력
		String username = param.getString("sms_id");	//필수입력
		String key = param.getString("sms_key");		//필수입력
		String rdoSendType = param.getString("rdoSendType");
		String rdate = param.getString("rdate");
		String rtime = param.getString("rtime");
		
		//수신자 정보 추가 - 필수 입력(주소록 미사용시), 치환문자 미사용시 치환문자 데이터를 입력하지 않고 사용할 수 있습니다.
		String recipients = param.getString("rphone");
		recipients = recipients.replace(" ", "").replace("-", "");
		
		//복수 수신
		String[] recipients_arry = recipients.split(",");
		int receiverNum = recipients_arry.length;
		
		String receiver = "";
		if(receiverNum > 1){
			for(int i=0; i<receiverNum; i++){
				receiver += "{\"mobile\":\"" + recipients_arry[i] + "\"}";
				
				if(receiverNum-1 > i){
					receiver += ",";
				}
			}
		} else {
			receiver += "{\"mobile\":\"" + recipients + "\"}";
		}
		
		receiver = "[" + receiver + "]";
		
		//예약 발송 정보
		String sms_type = "";
		if(rdoSendType.equals("S")){
			sms_type = "NORMAL";
		} else {
			sms_type = "ONETIME";
		}
		
		String start_reserve_time = rdate + rtime;
		String end_reserve_time = start_reserve_time;
		int remained_count = 1;
		
		message = message.replace(" ", " ");
		
		/////////////////////////////////////////////////////////////////////////////////////
		
		String data = "\"title\":\"" + title + "\"";
		data += ", \"message\":\"" + message + "\"";
		data += ", \"sender\":\"" + sender + "\"";
		data += ", \"username\":\"" + username + "\"";
		data += ", \"receiver\":" + receiver;
		
		//예약 관련 파라미터
		data += ", \"sms_type\":\"" + sms_type + "\"";
		data += ", \"start_reserve_time\":\"" + start_reserve_time + "\"";
		data += ", \"end_reserve_time\":\"" + end_reserve_time + "\"";
		data += ", \"remained_count\":\"" + remained_count + "\"";
		
		data += ", \"key\":\"" + key + "\"";
		data += ", \"type\":\"" + "jsp" + "\"";
		
		data = "{" + data + "}";
		
		URL url = new URL("https://directsend.co.kr/index.php/api_v2/sms_change_word");
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		
		conn.setRequestMethod("POST");
		conn.setRequestProperty("Accept", "application/json");
		conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
		conn.setDoOutput(true);
		conn.setDoInput(true);
		
		OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
		
		wr.write(data);
		wr.flush();
		wr.close();
		
		BufferedReader br;
		
		int responseCode = conn.getResponseCode();
		if(responseCode == 200){
			br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}
		
		StringBuffer res = new StringBuffer();
		String inputLine;
		
		while((inputLine = br.readLine()) != null){
			res.append(inputLine);
		}
		
		br.close();
		
		String json = res.toString();
		ObjectMapper mapper = new ObjectMapper();
		Map<Object, Object> list = mapper.readValue(json, new TypeReference<Map<Object, Object>>() {});
		
		model.addAttribute("list", list);
		
		return model;
	}
	
	@RequestMapping({"/{siteId}/system/sms/remainingMoney"})
	public ModelMap remainingMoney(HttpServletRequest request, HttpServletResponse response, @PathVariable String siteId, ModelMap model) throws Exception{
		ZValue param = WebFactory.getAttributes(request);
		
		String username = param.getString("sms_id");
		String key = param.getString("sms_key");
		
		String data = "{\"username\":\"" + username + "\", \"key\":\"" + key + "\", \"kakao_reserve\":\"1\"}";
		
		URL url = new URL("https://directsend.co.kr/index.php/api_v2/remaining_money");
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		
		conn.setRequestMethod("POST");
		conn.setRequestProperty("Accept", "application/json");
		conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
		conn.setDoOutput(true);
		conn.setDoInput(true);
		
		OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
		
		wr.write(data);
		wr.flush();
		wr.close();
		
		BufferedReader br;
		
		int responseCode = conn.getResponseCode();
		if(responseCode == 200){
			br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}
		
		StringBuffer res = new StringBuffer();
		String inputLine;
		
		while((inputLine = br.readLine()) != null){
			res.append(inputLine);
		}
		
		br.close();
		
		String json = res.toString();
		ObjectMapper mapper = new ObjectMapper();
		Map<Object, Object> list = mapper.readValue(json, new TypeReference<Map<Object, Object>>() {});
		
		model.addAttribute("list", list);
		
		return model;
	}
}

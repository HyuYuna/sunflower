package site.unp.cms.view;

import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.JsonEncoding;
import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.SerializationConfig;
import org.springframework.validation.BindingResult;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

public class UnpMappingJacksonJsonView extends MappingJackson2JsonView {

	private ObjectMapper objectMapper = new ObjectMapper();

	private JsonEncoding encoding = JsonEncoding.UTF8;

	public UnpMappingJacksonJsonView() {
		setContentType("application/json");
		setExposePathVariables(false);
	}

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		OutputStream stream = response.getOutputStream();

		Object value = null;
		if (model.get("singleJsonData") != null)
			value = unpfilterModel(model);
		else
			value = filterModel(model);

		if ("Y".equals(model.get("ieOprSe")))
			setContentType("text/plain;charset=UTF-8");

		JsonGenerator generator = this.objectMapper.getJsonFactory().createJsonGenerator(stream, this.encoding);

		// A workaround for JsonGenerators not applying serialization features
		// https://github.com/FasterXML/jackson-databind/issues/12
		if (this.objectMapper.getSerializationConfig().isEnabled(SerializationConfig.Feature.INDENT_OUTPUT)) {
			generator.useDefaultPrettyPrinter();
		}
		this.objectMapper.writeValue(generator, value);

	}

	/**
	 * model객체에 jsonData key값으로 담을경우 적용됨
	 */
	protected Object unpfilterModel(Map<String, Object> model) {
		Object result = null;
		Set<String> renderedAttributes = model.keySet();
		for (Map.Entry<String, Object> entry : model.entrySet()) {
			if (!(entry.getValue() instanceof BindingResult) && renderedAttributes.contains(entry.getKey()) && "singleJsonData".equals(entry.getKey())) {
				result = entry.getValue();
			}
		}
		return result;
	}

	/**
	 * error 또는 json형태가 아닌 메소드를 json으로 호출했을때 모든 정보가 다 노출되는 것을 방지
	 * 
	 * @param model
	 * @return
	 */
	@Override
	protected Object filterModel(Map<String, Object> model) {
		Map<String, Object> result = new HashMap<String, Object>(model.size());
		Set<String> renderedAttributes = model.keySet();
		for (Map.Entry<String, Object> entry : model.entrySet()) {
			if (!(entry.getValue() instanceof BindingResult) && renderedAttributes.contains(entry.getKey())) {

				// 예와로직 추가 start
				switch (entry.getKey()) {
				case "paramVO":
					break;
				case "userInfo":
					break;
				case "masterVO":
					break;
				case "fileMap":
					break;
				case "exception":
					result.put("exception", "Please contact the manager!");
					break;
				default:
					result.put(entry.getKey(), entry.getValue());
				}
				// 예와로직 추가 end
			}
		}
		return result;
	}
}

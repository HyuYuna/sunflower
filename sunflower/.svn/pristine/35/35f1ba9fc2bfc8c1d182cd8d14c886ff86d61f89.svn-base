package site.unp.cms.view;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

@Service
public class AnnotatedMappingJacksonJsonView extends MappingJackson2JsonView {

	Logger log = LoggerFactory.getLogger(this.getClass());
	
	private UnpJsonViewFinder unpJsonViewFinder;
	
	public AnnotatedMappingJacksonJsonView() {
		setContentType("application/json");
		setExposePathVariables(false);
	}

	public UnpJsonViewFinder getUnpJsonViewFinder() {
		return unpJsonViewFinder;
	}

	@Resource(name="unpJsonViewFinder")
	public void setUnpJsonViewFinder(UnpJsonViewFinder unpJsonViewFinder) {
		this.unpJsonViewFinder = unpJsonViewFinder;
	}

	/**
	 * error 또는 json형태가 아닌 메소드를 json으로 호출했을때 모든 정보가 다 노출되는 것을 방지
	 * 
	 * @param model
	 * @return
	 */
	@Override
	protected Object filterModel(Map<String, Object> model) {
		
		if ("Y".equals(model.get("ieOprSe"))) {
			setContentType("text/plain;charset=UTF-8");
		}
		
		Map<String, Object> result = new HashMap<String, Object>(model.size());
		Set<String> renderedAttributes = model.keySet();
		for (Map.Entry<String, Object> entry : model.entrySet()) {
			if (!(entry.getValue() instanceof BindingResult) && renderedAttributes.contains(entry.getKey()) && "singleJsonData".equals(entry.getKey())) {
				return entry.getValue();
			}
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
	
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		if (!unpJsonViewFinder.hasUnpJsonViewModel(model)) {
			//throw new FileNotFoundException();
			response.sendRedirect("/cmmn/error.jsp");
			return;
		}
		
		super.renderMergedOutputModel(model, request, response);

	}
	
}

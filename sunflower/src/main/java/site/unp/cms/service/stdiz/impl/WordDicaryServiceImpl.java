package site.unp.cms.service.stdiz.impl;

import org.springframework.stereotype.Service;

import site.unp.cms.service.stdiz.WordDicaryService;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.CommonServiceLink.LinkType;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;

@CommonServiceDefinition(
	pageQueryData="menuNo,wordSe,wordSeCd,searchCnd,searchWrd,pageUnit"
)
@CommonServiceLink(desc="용어사전(표준용어사전, 도메인사전, 항목사전)", linkType=LinkType.BOS)
@Service
public class WordDicaryServiceImpl extends DefaultCrudServiceImpl implements WordDicaryService{

}

package site.unp.cms.service.singl.impl;

import org.springframework.stereotype.Service;

import site.unp.cms.service.singl.UwamAlarmLogService;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.CommonServiceLink.LinkType;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;


@CommonServiceDefinition(
		pageQueryData="menuNo,searchCnd,searchWrd"
		)
@CommonServiceLink(desc="PUSH 로그 관리", linkType=LinkType.BOS)
@Service
public class UwamAlarmLogServiceImpl extends DefaultCrudServiceImpl implements UwamAlarmLogService{

}
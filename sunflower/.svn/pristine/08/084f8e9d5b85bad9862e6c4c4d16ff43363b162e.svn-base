package site.unp.cms.dao;

import javax.annotation.Resource;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import site.unp.core.dao.SqlDAO;

@SuppressWarnings("rawtypes")
@Repository("upipsSqlDao")
public class UpipsSqlDAO extends SqlDAO {

    @Resource(name = "upipsSqlSession")
    public void setSqlSessionFactory(SqlSessionFactory sqlSession) {
    	super.setSqlSessionTemplate(new SqlSessionTemplate(sqlSession, ExecutorType.BATCH));
    }
}

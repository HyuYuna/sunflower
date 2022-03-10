package site;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.sql.DataSource;

import org.apache.commons.io.FileUtils;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.util.StringUtils;

import site.unp.core.util.StrUtils;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {
    "classpath*:egovframework/spring/unp/*.xml",
    "classpath*:egovframework/spring/prjct/*.xml"
})
@ActiveProfiles({"junit"})
public class MybatisXmlMakeTest {
	
	@Resource(name="ucms.dataSource")
	private DataSource ds;

	@Test
	public void test() throws Exception {
    	String[] tableNames = {"TN_CVPL_MASTR", "TN_CVPL_DSPLAY", "TN_CVPL_HIST", "TN_CVPL_TMLMT", "TN_CVPL_ANSWER"};
    	for (String tableName : tableNames) {
    		if (StringUtils.hasText(tableName)) {
            	StringBuffer result = new StringBuffer();
            	StringBuffer query = new StringBuffer();
            	query.append("SELECT * FROM ALL_TAB_COLUMNS WHERE TABLE_NAME = '").append(tableName).append("'");
            	/*
            	query.append("SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, COLUMN_COMMENT COMMENTS, ORDINAL_POSITION COLUMN_ID, COLUMN_KEY pk ");
            	query.append("\nFROM db_attribute a ");
            	query.append("\nWHERE TABLE_SCHEMA = 'fintech' AND  TABLE_NAME = '").append(tableName).append("'");
            	query.append("\nORDER BY TABLE_NAME, ORDINAL_POSITION");
            	*/
            	System.out.println(query.toString());
            	JdbcTemplate jdbcTemplate = new JdbcTemplate(ds);
            	List<Map<String,Object>> columnList = jdbcTemplate.queryForList(query.toString());
            	result.append("\n\n");
            	result.append(convertInsertCC(tableName, columnList)).append("\n\n");
            	result.append("\n\n");

            	result.append("\n\n");
            	result.append(convertUpdateCC(tableName, columnList)).append("\n\n");
            	result.append("\n\n");

            	result.append("\n\n");
            	result.append(convertResultMapCC(columnList)).append("\n\n");
            	result.append("\n\n");

            	result.append("\n\n");
            	result.append(printSelect(tableName, columnList)).append("\n\n");
            	result.append("\n\n");

            	result.append("\n\n");
            	result.append(printDelete(tableName)).append("\n\n");
            	result.append("\n\n");
            	
            	FileUtils.writeStringToFile(new File("E:/Temp/" + tableName + ".txt"), result.toString());
            	
            	/*
            	convertResultMapCC(columnList);
            	System.out.println("\n\n");
            	convertUpdateCC(tableName, columnList);
            	System.out.println("\n\n");
            	printSelect(tableName, columnList);
            	System.out.println("\n\n");
            	printDelete(tableName);
            	*/
    		}
    	}
	}

	public static String convertInsertCC(String tableName, List<Map<String,Object>> columnList){
		StringBuffer result = new StringBuffer();
		result.append("\t\t\tINSERT INTO ").append(tableName).append(" (\n");
		result.append("\t\t\t    ");
		int size = columnList.size();
    	for(int i=0; i<size; i++){
    		Map<String, Object> m = columnList.get(i);
    		result.append(m.get("COLUMN_NAME"));
    		if( i != size-1 ){
    			result.append(",");
    		}
    		if( i != 0 && i % 5 == 0 ){
    			result.append("\n    ");
    		}
    	}
		result.append("\n\t\t\t)\n");
		result.append("\t\t\tVALUES (\n");
		result.append("\t\t\t    ");
    	for(int i=0; i<size; i++){
    		Map<String, Object> m = columnList.get(i);
    		String dataType = m.get("DATA_TYPE").toString();
    		String colName = StrUtils.convert2CamelCase(m.get("COLUMN_NAME").toString());
    		if( "CLOB".equals(dataType) ){
    			result.append("#{").append(colName).append(":CLOB}");
    		}
    		else if ( "DATETIME".equals(dataType) ){
        		//result.append("SYSDATE");;
        		result.append("#{").append(colName).append("}");;
    		}
    		else {
        		result.append("#{").append(colName).append("}");;
    		}
    		if( i != size-1 ){
    			result.append(",");
    		}
    		if( i != 0 && i % 5 == 0 ){
    			result.append("\n\t\t\t    ");
    		}
    	}
    	result.append("\n\t\t\t)");
    	return result.toString();
	}

	public static String convertResultMapCC(List<Map<String,Object>> columnList){
		StringBuffer result = new StringBuffer();
		result.append("<resultMap id=\"mapId\" class=\"zvl\">\n");
		int size = columnList.size();
    	for(int i=0; i<size; i++){
    		Map<String, Object> m = columnList.get(i);
    		String colName = m.get("COLUMN_NAME").toString();
    		String dataType = m.get("DATA_TYPE").toString();
    		result.append("    <result property=\"").append(StrUtils.convert2CamelCase(colName)).append("\" column=\"").append(colName).append("\"");
    		if( "CLOB".equals(dataType) ){
    			result.append(" jdbcType=\"CLOB\" javaType=\"java.lang.String\"");
    		}
    		result.append("/>\n");
    	}
		result.append("</resultMap>");
    	return result.toString();
	}

	public static String convertUpdateCC(String tableName, List<Map<String,Object>> columnList){
		StringBuffer result = new StringBuffer();
		result.append("UPDATE ").append(tableName).append("\n");
		result.append("SET \n");
		int size = columnList.size();
    	for(int i=0; i<size; i++){
    		Map<String, Object> m = columnList.get(i);
    		String colName = m.get("COLUMN_NAME").toString();
    		String dataType = m.get("DATA_TYPE").toString();
    		result.append("    ").append(colName).append(" = ");
    		if ( "CLOB".equals(dataType) ) {
    			result.append("CHAR_TO_CLOB(#{").append(colName).append("})");
    		}
    		else {
    			result.append("#{").append(StrUtils.convert2CamelCase(colName)).append("}");
    		}
    		if( i != size-1 ){
    			result.append(",\n");
    		}
    	}
		result.append("\nWHERE 1=1");
    	return result.toString();
	}

	public static String printSelect(String tableName, List<Map<String,Object>> columnList){
		StringBuffer result = new StringBuffer();
		result.append("SELECT \n");
		int size = columnList.size();
    	for(int i=0; i<size; i++){
    		Map<String, Object> m = columnList.get(i);
    		String colName = m.get("COLUMN_NAME").toString();
    		String dataType = m.get("DATA_TYPE").toString();
    		result.append("    ");
    		if ( "CLOB".equals(dataType) ) {
    			result.append("CLOB_TO_CHAR(A.").append(colName).append(") AS ").append(colName);
    		}
    		else if ( "DATETIME".equals(dataType) ) {
    			result.append("TO_CHAR(A.").append(colName).append(", 'yyyy-mm-dd') AS ").append(colName);
    		}
    		else {
    			result.append("A.").append(colName);
    		}
    		if( i != size-1 ){
    			result.append(",\n");
    		}
    	}
    	result.append("\nFROM ").append(tableName).append(" A\n");
		result.append("WHERE 1=1");
    	return result.toString();
	}

	public static String printDelete(String tableName){
		StringBuffer result = new StringBuffer();
		result.append("DELETE FROM ").append(tableName).append("\n");
		result.append("WHERE 1=1");
    	return result.toString();
	}
}

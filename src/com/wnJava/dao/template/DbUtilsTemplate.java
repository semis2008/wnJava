package com.wnJava.dao.template;

import java.sql.SQLException; 
import java.util.ArrayList; 
import java.util.List; 
import java.util.Map; 

import javax.sql.DataSource; 

import org.apache.commons.dbutils.QueryRunner; 
import org.apache.commons.dbutils.handlers.BeanHandler; 
import org.apache.commons.dbutils.handlers.BeanListHandler; 
import org.apache.commons.dbutils.handlers.MapHandler; 
import org.apache.commons.dbutils.handlers.MapListHandler; 
import org.apache.commons.dbutils.handlers.ScalarHandler; 
import org.apache.log4j.Logger;

import com.mchange.v2.c3p0.ComboPooledDataSource;

/** 
* 调用Apache Commons DBUtil组件的数据库操作类 
* 采用c3p0作为数据源，数据源在Spring中已经配置好 
* 本类已经在Spring中配置好，在需要的地方，set注入后即可调用 
* <code> 
* private DbUtilsTemplate dbUtilsTemplate; 
* public void setDbUtilsTemplate(DbUtilsTemplate dbUtilsTemplate) { 
*     this.dbUtilsTemplate = dbUtilsTemplate; 
* } 
* </code> 
* @author Kalor 
* @time 2012-12-14 
*/ 
public class DbUtilsTemplate { 

    private DataSource dataSource; 
    private QueryRunner queryRunner; 
    private static final Logger LOG = Logger.getLogger(DbUtilsTemplate.class); 

    public void setDataSource(ComboPooledDataSource dataSource) { 
        this.dataSource = dataSource; 
    } 

    /** 
     * 执行sql语句 
     * @param sql sql语句 
     * @return 受影响的行数 
     */ 
    public int update(String sql) { 
        return update(sql, null); 
    } 
      
    /** 
     * 执行sql语句 
     * <code> 
     * executeUpdate("update user set username = 'kitty' where username = ?", "hello kitty"); 
     * </code> 
     * @param sql sql语句 
     * @param param 参数 
     * @return 受影响的行数 
     */ 
    public int update(String sql, Object param) { 
        return update(sql, new Object[] { param }); 
    } 
      
    /** 
     * 执行sql语句 
     * @param sql sql语句 
     * @param params 参数数组 
     * @return 受影响的行数
     */ 
    public int update(String sql, Object[] params) { 
        queryRunner = new QueryRunner(dataSource); 
        int affectedRows = 0; 
        try { 
            if (params == null) { 
                affectedRows = queryRunner.update(sql); 
            } else { 
                affectedRows = queryRunner.update(sql, params);
            } 
        } catch (SQLException e) { 
            LOG.error("Error occured while attempting to update data", e); 
        } 
        return affectedRows;
    } 
      
    /**
     * 获取上一次操作所影响的主键，用于插入insert
     * @return
     * @throws SQLException
     */
    public Long getLastActPriId() {
    	Long id = 0l;
    	try {
			id = (Long) queryRunner.query("SELECT LAST_INSERT_ID()", new ScalarHandler(1));
		} catch (SQLException e) {
			e.printStackTrace();
		} 
    	return id;
    }
    
    
    /** 
     * 执行批量sql语句 
     * @param sql sql语句 
     * @param params 二维参数数组 
     * @return 受影响的行数的数组 
     */ 
    public int[] batchUpdate(String sql, Object[][] params) { 
        queryRunner = new QueryRunner(dataSource); 
        int[] affectedRows = new int[0]; 
        try { 
            affectedRows = queryRunner.batch(sql, params); 
        } catch (SQLException e) { 
            LOG.error("Error occured while attempting to batch update data", e); 
        } 
        return affectedRows; 
    }     

    /** 
     * 执行查询，将每行的结果保存到一个Map对象中，然后将所有Map对象保存到List中 
     * @param sql sql语句 
     * @return 查询结果 
     */ 
    public List<Map<String, Object>> find(String sql) { 
        return find(sql, null); 
    } 
      
    /** 
     * 执行查询，将每行的结果保存到一个Map对象中，然后将所有Map对象保存到List中 
     * @param sql sql语句 
     * @param param 参数 
     * @return 查询结果 
     */ 
    public List<Map<String, Object>> find(String sql, Object param) { 
        return find(sql, new Object[] {param}); 
    } 
      
    /** 
     * 执行查询，将每行的结果保存到一个Map对象中，然后将所有Map对象保存到List中 
     * @param sql sql语句 
     * @param params 参数数组 
     * @return 查询结果 
     */ 
    public List<Map<String, Object>> find(String sql, Object[] params) { 
        queryRunner = new QueryRunner(dataSource); 
        List<Map<String, Object>> list = new ArrayList<Map<String,Object>>(); 
        try { 
            if (params == null) { 
                list = (List<Map<String, Object>>) queryRunner.query(sql, new MapListHandler()); 
            } else { 
                list = (List<Map<String, Object>>) queryRunner.query(sql, new MapListHandler(), params); 
            } 
        } catch (SQLException e) { 
            LOG.error("Error occured while attempting to query data", e); 
        } 
        return list; 
    } 
      
    /** 
     * 执行查询，将每行的结果保存到Bean中，然后将所有Bean保存到List中 
     * @param entityClass 类名 
     * @param sql sql语句 
     * @return 查询结果 
     */ 
    public <T> List<T> find(Class<T> entityClass, String sql) { 
        return find(entityClass, sql, null); 
    } 
      
    /** 
     * 执行查询，将每行的结果保存到Bean中，然后将所有Bean保存到List中 
     * @param entityClass 类名 
     * @param sql sql语句 
     * @param param 参数 
     * @return 查询结果 
     */ 
    public <T> List<T> find(Class<T> entityClass, String sql, Object param) { 
        return find(entityClass, sql, new Object[] { param }); 
    } 
      
    /** 
     * 执行查询，将每行的结果保存到Bean中，然后将所有Bean保存到List中 
     * @param entityClass 类名 
     * @param sql sql语句 
     * @param params 参数数组 
     * @return 查询结果 
     */ 
    @SuppressWarnings({ "unchecked", "rawtypes" }) 
    public <T> List<T> find(Class<T> entityClass, String sql, Object[] params) { 
        queryRunner = new QueryRunner(dataSource); 
        List<T> list = new ArrayList<T>(); 
        try { 
            if (params == null) { 
                list = (List<T>) queryRunner.query(sql, new BeanListHandler(entityClass)); 
            } else { 
                list = (List<T>) queryRunner.query(sql, new BeanListHandler(entityClass), params); 
            } 
        } catch (SQLException e) { 
            LOG.error("Error occured while attempting to query data", e); 
        } 
        return list; 
    } 
      
    /** 
     * 查询出结果集中的第一条记录，并封装成对象 
     * @param entityClass 类名 
     * @param sql sql语句 
     * @return 对象 
     */ 
    public <T> T findFirst(Class<T> entityClass, String sql) { 
        return findFirst(entityClass, sql, null); 
    } 
      
    /** 
     * 查询出结果集中的第一条记录，并封装成对象 
     * @param entityClass 类名 
     * @param sql sql语句 
     * @param param 参数 
     * @return 对象 
     */ 
    public <T> T findFirst(Class<T> entityClass, String sql, Object param) { 
        return findFirst(entityClass, sql, new Object[] { param }); 
    } 
      
    /** 
     * 查询出结果集中的第一条记录，并封装成对象 
     * @param entityClass 类名 
     * @param sql sql语句 
     * @param params 参数数组 
     * @return 对象 
     */ 
    @SuppressWarnings({ "unchecked", "rawtypes" }) 
    public <T> T findFirst(Class<T> entityClass, String sql, Object[] params) { 
        queryRunner = new QueryRunner(dataSource); 
        Object object = null; 
        try { 
            if (params == null) { 
                object = queryRunner.query(sql, new BeanHandler(entityClass)); 
            } else { 
                object = queryRunner.query(sql, new BeanHandler(entityClass), params); 
            } 
        } catch (SQLException e) { 
            LOG.error("Error occured while attempting to query data", e); 
        } 
        return (T) object; 
    } 
      
    /** 
     * 查询出结果集中的第一条记录，并封装成Map对象 
     * @param sql sql语句 
     * @return 封装为Map的对象 
     */ 
    public Map<String, Object> findFirst(String sql) { 
        return findFirst(sql, null); 
    } 
      
    /** 
     * 查询出结果集中的第一条记录，并封装成Map对象 
     * @param sql sql语句 
     * @param param 参数 
     * @return 封装为Map的对象 
     */ 
    public Map<String, Object> findFirst(String sql, Object param) { 
        return findFirst(sql, new Object[] { param }); 
    } 
      
    /** 
     * 查询出结果集中的第一条记录，并封装成Map对象 
     * @param sql sql语句 
     * @param params 参数数组 
     * @return 封装为Map的对象 
     */ 
    public Map<String, Object> findFirst(String sql, Object[] params) { 
        queryRunner = new QueryRunner(dataSource); 
        Map<String, Object> map = null; 
        try { 
            if (params == null) { 
                map = (Map<String, Object>) queryRunner.query(sql, new MapHandler()); 
            } else { 
                map = (Map<String, Object>) queryRunner.query(sql, new MapHandler(), params); 
            } 
        } catch (SQLException e) { 
            LOG.error("Error occured while attempting to query data", e); 
        } 
        return map; 
    } 
      
    /** 
     * 查询某一条记录，并将指定列的数据转换为Object 
     * @param sql sql语句 
     * @param columnName 列名 
     * @return 结果对象 
     */ 
    public Object findBy(String sql, String columnName) { 
        return findBy(sql, columnName, null); 
    } 
      
    /** 
     * 查询某一条记录，并将指定列的数据转换为Object 
     * @param sql sql语句 
     * @param columnName 列名 
     * @param param 参数 
     * @return 结果对象 
     */ 
    public Object findBy(String sql, String columnName, Object param) { 
        return findBy(sql, columnName, new Object[] { param }); 
    } 
      
    /** 
     * 查询某一条记录，并将指定列的数据转换为Object 
     * @param sql sql语句 
     * @param columnName 列名 
     * @param params 参数数组 
     * @return 结果对象 
     */ 
    public Object findBy(String sql, String columnName, Object[] params) { 
        queryRunner = new QueryRunner(dataSource); 
        Object object = null; 
        try { 
            if (params == null) { 
                object = queryRunner.query(sql, new ScalarHandler(columnName)); 
            } else { 
                object = queryRunner.query(sql, new ScalarHandler(columnName), params); 
            } 
        } catch (SQLException e) { 
            LOG.error("Error occured while attempting to query data", e); 
        } 
        return object; 
    } 
      
    /** 
     * 查询某一条记录，并将指定列的数据转换为Object 
     * @param sql sql语句 
     * @param columnIndex 列索引 
     * @return 结果对象 
     */ 
    public Object findBy(String sql, int columnIndex) { 
        return findBy(sql, columnIndex, null); 
    } 
      
    /** 
     * 查询某一条记录，并将指定列的数据转换为Object 
     * @param sql sql语句 
     * @param columnIndex 列索引 
     * @param param 参数 
     * @return 结果对象 
     */ 
    public Object findBy(String sql, int columnIndex, Object param) { 
        return findBy(sql, columnIndex, new Object[] { param }); 
    } 
      
    /** 
     * 查询某一条记录，并将指定列的数据转换为Object 
     * @param sql sql语句 
     * @param columnIndex 列索引 
     * @param params 参数数组 
     * @return 结果对象 
     */ 
    public Object findBy(String sql, int columnIndex, Object[] params) { 
        queryRunner = new QueryRunner(dataSource); 
        Object object = null; 
        try { 
            if (params == null) { 
                object = queryRunner.query(sql, new ScalarHandler(columnIndex)); 
            } else { 
                object = queryRunner.query(sql, new ScalarHandler(columnIndex), params); 
            } 
        } catch (SQLException e) { 
            LOG.error("Error occured while attempting to query data", e); 
        } 
        return object; 
    } 
}
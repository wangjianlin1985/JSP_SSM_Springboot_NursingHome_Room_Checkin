﻿package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.EmployeeService;
import com.chengxusheji.po.Employee;
import com.chengxusheji.service.DepartmentService;
import com.chengxusheji.po.Department;

//Employee管理控制层
@Controller
@RequestMapping("/Employee")
public class EmployeeController extends BaseController {

    /*业务层对象*/
    @Resource EmployeeService employeeService;

    @Resource DepartmentService departmentService;
	@InitBinder("departmentObj")
	public void initBinderdepartmentObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("departmentObj.");
	}
	@InitBinder("employee")
	public void initBinderEmployee(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("employee.");
	}
	/*跳转到添加Employee视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Employee());
		/*查询所有的Department信息*/
		List<Department> departmentList = departmentService.queryAllDepartment();
		request.setAttribute("departmentList", departmentList);
		return "Employee_add";
	}

	/*客户端ajax方式提交添加员工信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Employee employee, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		if(employeeService.getEmployee(employee.getEmployeeNo()) != null) {
			message = "用户名已经存在！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			employee.setEmployeePhoto(this.handlePhotoUpload(request, "employeePhotoFile"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
        employeeService.addEmployee(employee);
        message = "员工添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询员工信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String employeeNo,@ModelAttribute("departmentObj") Department departmentObj,String name,String birthDate,String telephone,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (employeeNo == null) employeeNo = "";
		if (name == null) name = "";
		if (birthDate == null) birthDate = "";
		if (telephone == null) telephone = "";
		if(rows != 0)employeeService.setRows(rows);
		List<Employee> employeeList = employeeService.queryEmployee(employeeNo, departmentObj, name, birthDate, telephone, page);
	    /*计算总的页数和总的记录数*/
	    employeeService.queryTotalPageAndRecordNumber(employeeNo, departmentObj, name, birthDate, telephone);
	    /*获取到总的页码数目*/
	    int totalPage = employeeService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = employeeService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Employee employee:employeeList) {
			JSONObject jsonEmployee = employee.getJsonObject();
			jsonArray.put(jsonEmployee);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询员工信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Employee> employeeList = employeeService.queryAllEmployee();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Employee employee:employeeList) {
			JSONObject jsonEmployee = new JSONObject();
			jsonEmployee.accumulate("employeeNo", employee.getEmployeeNo());
			jsonEmployee.accumulate("name", employee.getName());
			jsonArray.put(jsonEmployee);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询员工信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String employeeNo,@ModelAttribute("departmentObj") Department departmentObj,String name,String birthDate,String telephone,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (employeeNo == null) employeeNo = "";
		if (name == null) name = "";
		if (birthDate == null) birthDate = "";
		if (telephone == null) telephone = "";
		List<Employee> employeeList = employeeService.queryEmployee(employeeNo, departmentObj, name, birthDate, telephone, currentPage);
	    /*计算总的页数和总的记录数*/
	    employeeService.queryTotalPageAndRecordNumber(employeeNo, departmentObj, name, birthDate, telephone);
	    /*获取到总的页码数目*/
	    int totalPage = employeeService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = employeeService.getRecordNumber();
	    request.setAttribute("employeeList",  employeeList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("employeeNo", employeeNo);
	    request.setAttribute("departmentObj", departmentObj);
	    request.setAttribute("name", name);
	    request.setAttribute("birthDate", birthDate);
	    request.setAttribute("telephone", telephone);
	    List<Department> departmentList = departmentService.queryAllDepartment();
	    request.setAttribute("departmentList", departmentList);
		return "Employee/employee_frontquery_result"; 
	}

     /*前台查询Employee信息*/
	@RequestMapping(value="/{employeeNo}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable String employeeNo,Model model,HttpServletRequest request) throws Exception {
		/*根据主键employeeNo获取Employee对象*/
        Employee employee = employeeService.getEmployee(employeeNo);

        List<Department> departmentList = departmentService.queryAllDepartment();
        request.setAttribute("departmentList", departmentList);
        request.setAttribute("employee",  employee);
        return "Employee/employee_frontshow";
	}

	/*ajax方式显示员工修改jsp视图页*/
	@RequestMapping(value="/{employeeNo}/update",method=RequestMethod.GET)
	public void update(@PathVariable String employeeNo,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键employeeNo获取Employee对象*/
        Employee employee = employeeService.getEmployee(employeeNo);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonEmployee = employee.getJsonObject();
		out.println(jsonEmployee.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新员工信息*/
	@RequestMapping(value = "/{employeeNo}/update", method = RequestMethod.POST)
	public void update(@Validated Employee employee, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String employeePhotoFileName = this.handlePhotoUpload(request, "employeePhotoFile");
		if(!employeePhotoFileName.equals("upload/NoImage.jpg"))employee.setEmployeePhoto(employeePhotoFileName); 


		try {
			employeeService.updateEmployee(employee);
			message = "员工更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "员工更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除员工信息*/
	@RequestMapping(value="/{employeeNo}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable String employeeNo,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  employeeService.deleteEmployee(employeeNo);
	            request.setAttribute("message", "员工删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "员工删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条员工记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String employeeNos,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = employeeService.deleteEmployees(employeeNos);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出员工信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String employeeNo,@ModelAttribute("departmentObj") Department departmentObj,String name,String birthDate,String telephone, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(employeeNo == null) employeeNo = "";
        if(name == null) name = "";
        if(birthDate == null) birthDate = "";
        if(telephone == null) telephone = "";
        List<Employee> employeeList = employeeService.queryEmployee(employeeNo,departmentObj,name,birthDate,telephone);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Employee信息记录"; 
        String[] headers = { "用户名","所在部门","姓名","性别","出生日期","员工照片","联系电话"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<employeeList.size();i++) {
        	Employee employee = employeeList.get(i); 
        	dataset.add(new String[]{employee.getEmployeeNo(),employee.getDepartmentObj().getDepartName(),employee.getName(),employee.getGender(),employee.getBirthDate(),employee.getEmployeePhoto(),employee.getTelephone()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"Employee.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}

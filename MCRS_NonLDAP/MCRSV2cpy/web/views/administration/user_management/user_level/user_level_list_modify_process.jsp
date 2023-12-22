<%@include file="../../../../includes/check_auth_layer3.jsp"%>
<%

    String userID = v_userID;
    String username = v_userName;
    String actionCode = request.getParameter("actionCode");
    String actionDesc = "";
    String formName="Record";
    String tableName="t_user_level";
    String seqTableName=tableName+"_seq";
    String id="0";
    
    if (actionCode.equals("EDT")){
    id = request.getParameter("id");
    }
    
    String level_code=request.getParameter("level_code");
    String level_name=request.getParameter("level_name");
    String level_description=request.getParameter("level_description");
    String document_pathkey=request.getParameter("document_pathkey");
 

    
    
    //VALIDATION
    boolean validate = true;
    String errorMessage = "";
    
    
    if (level_code.equals("")){
    level_code="NULL";
    validate = false;
    errorMessage += "- Field level_code tidak boleh null <br>";
    }
    
    if (level_name.equals("")){
    level_name="NULL";
    validate = false;
    errorMessage += "- Field level_name tidak boleh null <br>";
    }
    
    
    
  
 
    
    if (validate) {
        try {
            ResultSet resultSet=null;
            Database db = new Database();
            try {
                db.connect(1);
                String sql;
                
                //out.println("<div class=info>" +cabangGroupID +username+ "</div>");
                
               if (actionCode.equals("ADD")) {
                sql = "insert into "+tableName+" ("
                    +"id, level_code,level_name,level_description, document_pathkey) "
                    +"values ( "
                    + "nextval('"+seqTableName+"'),"
                    + "'"+level_code+"',"
                    + "'"+level_name+"',"
                    + "'"+level_description+"', "
                    + "'"+document_pathkey+"' "
                    + " )";
                    
                actionDesc="Add";
                        
               }else {
                   
                 sql = "update "+tableName+" SET "
                    +"level_code='"+level_code+"',"
                    +"level_name='"+level_name+"', "
                    +"level_description='"+level_description+"', "
                    +"document_pathkey='"+document_pathkey+"' "     
                    +" where id="+id;
                 
                 actionDesc="Edit";
                   
               }
               
               
               //debug mode            
                        if (v_debugMode.equals("1")) {
                        out.println("<div class=sql>"+sql+"</div>");
                        }
                        
                db.executeUpdate(sql);
                out.println("<div class=info>"+actionDesc+" "+formName+" Success<br></div>");
                
                 %>
                <script type="text/javascript">
                    
                    filter_itemname= document.getElementById("filter_itemname").value;
                    $("#data").empty();
                    $('#loading').show();
                    $.ajax({
                        type: 'POST',
                        url: "administration/user_management/user_level/user_level_list_data.jsp",
                        data: {id:<%=id%>,
                                filter_itemname:filter_itemname
                            },
                        success: function(data) {
                            $("#data_inner").empty();
                            $('#data_inner').html(data);
                            $("#data_inner").show();
                            $("#status_msg").delay(5000).hide(400);                  
                        },
                        complete: function(){
                            $('#loading').hide();
                        }
                    });
                </script>
                    <%
                    
            } catch (SQLException Sqlex) {
                out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
            } finally {
                db.close();
                if (resultSet != null) resultSet.close(); 
            }
        } catch (Exception except) {
            out.println("<div class=sql>" + except.getMessage() + "</div>");
        }
        
        
    } else {
        out.println("<div class=alert>" + errorMessage + "</div>");
    }

    

    
    
%>


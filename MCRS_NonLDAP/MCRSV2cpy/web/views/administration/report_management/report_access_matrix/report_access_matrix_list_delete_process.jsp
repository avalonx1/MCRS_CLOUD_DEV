<%@include file="../../../../includes/check_auth_layer3.jsp"%>
<%  
              
    String id = request.getParameter("id");
    String tableName="t_report_permission_matrix";
    
    String sql;
    
    
        try {
            ResultSet resultSet = null;
            Database db = new Database();
            try {
                db.connect(1);
                    
                sql = "delete from "+tableName+" where ID=" + id + " ";
                //System.out.println(sql);
                
                //debug mode            
                        if (v_debugMode.equals("1")) {
                        out.println("<div class=sql>"+sql+"</div>");
                        }
                        
                db.executeUpdate(sql);
                out.println("<div class=info> Delete ID "+id+" success..</div>");
                    
            } catch (SQLException Sqlex) {
                out.println("<div class=sql>" + Sqlex.getMessage() + "</div>");
            } finally {
                db.close();
                    if (resultSet != null) resultSet.close(); 
            }
        } catch (Exception except) {
            out.println("<div class=sql>" + except.getMessage() + "</div>");
        }
%>
<script type="text/javascript">
 
            filter_itemname= document.getElementById("filter_itemname").value;
                    filter_report_id = document.getElementById("filter_report_id").value;
                    filter_group_master_id = document.getElementById("filter_group_master_id").value;
                    filter_group_child_id = document.getElementById("filter_group_child_id").value;
                    filter_userlevel_id = document.getElementById("filter_userlevel_id").value;
                    
                    
    $.ajax({
        type: 'POST',
        url: "administration/report_management/report_access_matrix/report_access_matrix_list_data.jsp",
        data: {id:0,
                            filter_itemname:filter_itemname,
                            filter_report_id:filter_report_id,
                            filter_group_master_id:filter_group_master_id,
                            filter_group_child_id:filter_group_child_id,
                            filter_userlevel_id:filter_userlevel_id
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
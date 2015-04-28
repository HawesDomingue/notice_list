set define off
set verify off
set feedback off
WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK
begin wwv_flow.g_import_in_progress := true; end; 
/
 
--       AAAA       PPPPP   EEEEEE  XX      XX
--      AA  AA      PP  PP  EE       XX    XX
--     AA    AA     PP  PP  EE        XX  XX
--    AAAAAAAAAA    PPPPP   EEEE       XXXX
--   AA        AA   PP      EE        XX  XX
--  AA          AA  PP      EE       XX    XX
--  AA          AA  PP      EEEEEE  XX      XX
prompt  Set Credentials...
 
begin
 
  -- Assumes you are running the script connected to SQL*Plus as the Oracle user APEX_040100 or as the owner (parsing schema) of the application.
  wwv_flow_api.set_security_group_id(p_security_group_id=>nvl(wwv_flow_application_install.get_workspace_id,1251212041416172));
 
end;
/

begin wwv_flow.g_import_in_progress := true; end;
/
begin 

select value into wwv_flow_api.g_nls_numeric_chars from nls_session_parameters where parameter='NLS_NUMERIC_CHARACTERS';

end;

/
begin execute immediate 'alter session set nls_numeric_characters=''.,''';

end;

/
begin wwv_flow.g_browser_language := 'en'; end;
/
prompt  Check Compatibility...
 
begin
 
-- This date identifies the minimum version required to import this file.
wwv_flow_api.set_version(p_version_yyyy_mm_dd=>'2011.02.12');
 
end;
/

prompt  Set Application ID...
 
begin
 
   -- SET APPLICATION ID
   wwv_flow.g_flow_id := nvl(wwv_flow_application_install.get_application_id,654321);
   wwv_flow_api.g_id_offset := nvl(wwv_flow_application_install.get_offset,0);
null;
 
end;
/

prompt  ...plugins
--
--application/shared_components/plugins/item_type/com_oracle_apex_group_selectlist
 
begin
 
wwv_flow_api.create_plugin (
  p_id => 2525436140086505024 + wwv_flow_api.g_id_offset
 ,p_flow_id => wwv_flow.g_flow_id
 ,p_plugin_type => 'ITEM TYPE'
 ,p_name => 'COM.ORACLE.APEX.GROUP_SELECTLIST'
 ,p_display_name => 'Group Select List'
 ,p_image_prefix => '#PLUGIN_PREFIX#'
 ,p_plsql_code => 
'-- The render procedure is responsible for the rendering of the actual HTML control'||unistr('\000a')||
'-- of the new widget. APEX still takes care of the table cell for the layout,'||unistr('\000a')||
'-- the label, pre- and post element text. Only the html code between the pre- and'||unistr('\000a')||
'-- post element text is rendered by the plug-in. The render procedure has a'||unistr('\000a')||
'-- defined interface which every plug-in has to implement. It''s designed in a wa'||
'y'||unistr('\000a')||
'-- that future enhancements to the interface will not break existing plug-ins.'||unistr('\000a')||
'function render_group_selectlist ('||unistr('\000a')||
'    p_item                in apex_plugin.t_page_item,'||unistr('\000a')||
'    p_plugin              in apex_plugin.t_plugin,'||unistr('\000a')||
'    p_value               in varchar2,'||unistr('\000a')||
'    p_is_readonly         in boolean,'||unistr('\000a')||
'    p_is_printer_friendly in boolean )'||unistr('\000a')||
'    return apex_plugin.t_page_item_render_result'||unistr('\000a')||
'is'||unistr('\000a')||
'    -- cons'||
'tants for accessing our l_column_value_list array'||unistr('\000a')||
'    c_display_column constant number := 1;'||unistr('\000a')||
'    c_return_column  constant number := 2;'||unistr('\000a')||
'    c_group_column   constant number := 3;'||unistr('\000a')||
'    '||unistr('\000a')||
'    -- value without the lov null value'||unistr('\000a')||
'    l_value             varchar2(32767) := case when p_value = p_item.lov_null_value then null else p_value end;'||unistr('\000a')||
''||unistr('\000a')||
'    l_name              varchar2(30);'||unistr('\000a')||
'    l_display_value     '||
'varchar2(32767);'||unistr('\000a')||
'    l_is_selected       boolean := false;'||unistr('\000a')||
'    l_value_found       boolean := false;'||unistr('\000a')||
'    l_column_value_list wwv_flow_plugin_util.t_column_value_list;'||unistr('\000a')||
'    l_group_value       varchar2(4000);'||unistr('\000a')||
'    l_last_group_value  varchar2(4000);'||unistr('\000a')||
'    l_open_group        boolean := false;'||unistr('\000a')||
'    l_result            wwv_flow_plugin.t_page_item_render_result;'||unistr('\000a')||
'    '||unistr('\000a')||
'    procedure print_option_local ('||unistr('\000a')||
'    '||
'    p_display_value in varchar2,'||unistr('\000a')||
'        p_return_value  in varchar2,'||unistr('\000a')||
'        p_compare_value in varchar2 )'||unistr('\000a')||
'    is'||unistr('\000a')||
'        l_is_selected boolean := false;'||unistr('\000a')||
'    begin'||unistr('\000a')||
'        if not l_value_found and apex_plugin_util.is_equal(p_return_value, p_compare_value)'||unistr('\000a')||
'        then'||unistr('\000a')||
'            l_value_found := true;'||unistr('\000a')||
'            l_is_selected := true;'||unistr('\000a')||
'        end if;'||unistr('\000a')||
'        -- add list entry'||unistr('\000a')||
'        apex_plugi'||
'n_util.print_option ('||unistr('\000a')||
'            p_display_value => p_display_value,'||unistr('\000a')||
'            p_return_value  => p_return_value,'||unistr('\000a')||
'            p_is_selected   => l_is_selected,'||unistr('\000a')||
'            p_attributes    => p_item.element_option_attributes );'||unistr('\000a')||
'    end print_option_local;'||unistr('\000a')||
'begin'||unistr('\000a')||
'    -- During plug-in development it''s very helpful to have some debug information'||unistr('\000a')||
'    if wwv_flow.g_debug then'||unistr('\000a')||
'        apex_plugin_util'||
'.debug_page_item ('||unistr('\000a')||
'            p_plugin              => p_plugin,'||unistr('\000a')||
'            p_page_item           => p_item,'||unistr('\000a')||
'            p_value               => p_value,'||unistr('\000a')||
'            p_is_readonly         => p_is_readonly,'||unistr('\000a')||
'            p_is_printer_friendly => p_is_printer_friendly );'||unistr('\000a')||
'    end if;'||unistr('\000a')||
''||unistr('\000a')||
'    -- Based on the flags we normally generate different HTML code, but that'||unistr('\000a')||
'    -- depends on the plug-in.'||unistr('\000a')||
'    if p'||
'_is_readonly or p_is_printer_friendly then'||unistr('\000a')||
'        apex_plugin_util.print_hidden_if_readonly ('||unistr('\000a')||
'            p_item_name           => p_item.name,'||unistr('\000a')||
'            p_value               => p_value,'||unistr('\000a')||
'            p_is_readonly         => p_is_readonly,'||unistr('\000a')||
'            p_is_printer_friendly => p_is_printer_friendly );'||unistr('\000a')||
''||unistr('\000a')||
'        -- get the display value'||unistr('\000a')||
'        l_display_value := apex_plugin_util.get_display_data '||
'('||unistr('\000a')||
'                               p_sql_statement     => p_item.lov_definition,'||unistr('\000a')||
'                               p_min_columns       => 3, -- LOV requires 3 column'||unistr('\000a')||
'                               p_max_columns       => 3,'||unistr('\000a')||
'                               p_component_name    => p_item.name,'||unistr('\000a')||
'                               p_display_column_no => c_display_column,'||unistr('\000a')||
'                               p_search_col'||
'umn_no  => c_return_column,'||unistr('\000a')||
'                               p_search_string     => l_value,'||unistr('\000a')||
'                               p_display_extra     => p_item.lov_display_extra );'||unistr('\000a')||
''||unistr('\000a')||
'        -- emit display span with the value'||unistr('\000a')||
'        apex_plugin_util.print_display_only ('||unistr('\000a')||
'            p_item_name        => p_item.name,'||unistr('\000a')||
'            p_display_value    => l_display_value,'||unistr('\000a')||
'            p_show_line_breaks => fals'||
'e,'||unistr('\000a')||
'            p_escape           => true,'||unistr('\000a')||
'            p_attributes       => p_item.element_attributes );'||unistr('\000a')||
'    else'||unistr('\000a')||
'        -- If a page item saves state, we have to call the get_input_name_for_page_item'||unistr('\000a')||
'        -- to render the internal hidden p_arg_names field. It will also return the'||unistr('\000a')||
'        -- HTML field name which we have to use when we render the HTML input field.'||unistr('\000a')||
'        l_name := apex_plugi'||
'n.get_input_name_for_page_item(false);'||unistr('\000a')||
'        sys.htp.prn(''<select name="''||l_name||''" id="''||p_item.name||''" ''||'||unistr('\000a')||
'                  coalesce(p_item.element_attributes, ''class="group_selectlist"'')||''>'');'||unistr('\000a')||
''||unistr('\000a')||
'        -- add display null entry'||unistr('\000a')||
'        if p_item.lov_display_null then'||unistr('\000a')||
'            -- add list entry'||unistr('\000a')||
'            print_option_local ('||unistr('\000a')||
'                    p_display_value => p_item.lov_null_tex'||
't,'||unistr('\000a')||
'                    p_return_value  => p_item.lov_null_value,'||unistr('\000a')||
'                    p_compare_value => nvl(l_value, p_item.lov_null_value) );'||unistr('\000a')||
''||unistr('\000a')||
'            -- We have to tell the APEX JS framework which value should be considered as NULL'||unistr('\000a')||
'            if p_item.lov_null_value is not null then'||unistr('\000a')||
'                apex_javascript.add_onload_code ('||unistr('\000a')||
'                    p_code => ''apex.widget.initPageItem('' '||
'|| apex_javascript.add_value(p_item.name) ||'||unistr('\000a')||
'                              ''{ '' || apex_javascript.add_attribute(''nullValue'', p_item.lov_null_value, true, false) || ''});'' );'||unistr('\000a')||
'            end if;'||unistr('\000a')||
'        end if;'||unistr('\000a')||
''||unistr('\000a')||
'        -- get all values'||unistr('\000a')||
'        l_column_value_list := apex_plugin_util.get_data ('||unistr('\000a')||
'                                   p_sql_statement      => p_item.lov_definition,'||unistr('\000a')||
'                      '||
'             p_min_columns        => 3,'||unistr('\000a')||
'                                   p_max_columns        => 3,'||unistr('\000a')||
'                                   p_component_name     => p_item.name );'||unistr('\000a')||
''||unistr('\000a')||
'        -- loop through the result'||unistr('\000a')||
'        for i in 1 .. l_column_value_list(c_display_column).count'||unistr('\000a')||
'        loop'||unistr('\000a')||
'            l_group_value := l_column_value_list(c_group_column)(i);'||unistr('\000a')||
'            -- has the group changed?'||unistr('\000a')||
'  '||
'          if (l_group_value <> l_last_group_value) or'||unistr('\000a')||
'               (l_group_value is     null and l_last_group_value is not null) or'||unistr('\000a')||
'               (l_group_value is not null and l_last_group_value is     null)'||unistr('\000a')||
'            then'||unistr('\000a')||
'                if l_open_group then'||unistr('\000a')||
'                    sys.htp.p(''</optgroup>'');'||unistr('\000a')||
'                    l_open_group := false;'||unistr('\000a')||
'                end if;'||unistr('\000a')||
'                if l'||
'_group_value is not null then'||unistr('\000a')||
'                    sys.htp.p (''<optgroup label="''||sys.htf.escape_sc(l_group_value)||''">'');'||unistr('\000a')||
'                    l_open_group := true;'||unistr('\000a')||
'                end if;'||unistr('\000a')||
'                l_last_group_value := l_group_value;'||unistr('\000a')||
'            end if;'||unistr('\000a')||
'            -- add list entry'||unistr('\000a')||
'            print_option_local ('||unistr('\000a')||
'                p_display_value => l_column_value_list(c_display_column)(i)'||
','||unistr('\000a')||
'                p_return_value  => l_column_value_list(c_return_column )(i),'||unistr('\000a')||
'                p_compare_value => l_value );'||unistr('\000a')||
'        end loop;'||unistr('\000a')||
''||unistr('\000a')||
'        if l_open_group then'||unistr('\000a')||
'            sys.htp.p(''</optgroup>'');'||unistr('\000a')||
'        end if;'||unistr('\000a')||
'        -- Show at least the value if it hasn''t been found in the database'||unistr('\000a')||
'        if not l_value_found and l_value is not null and p_item.lov_display_extra then'||unistr('\000a')||
'           '||
' print_option_local ('||unistr('\000a')||
'                p_display_value => l_value,'||unistr('\000a')||
'                p_return_value  => l_value,'||unistr('\000a')||
'                p_compare_value => l_value );'||unistr('\000a')||
'        end if;'||unistr('\000a')||
'        -- close our select list'||unistr('\000a')||
'        sys.htp.p(''</select>'');'||unistr('\000a')||
'        -- Tell APEX that this field is navigable'||unistr('\000a')||
'        l_result.is_navigable := true;'||unistr('\000a')||
'    end if;'||unistr('\000a')||
'    return l_result;'||unistr('\000a')||
'end render_group_selectlist;'
 ,p_render_function => 'render_group_selectlist'
 ,p_standard_attributes => 'VISIBLE:SESSION_STATE:READONLY:QUICKPICK:SOURCE:ELEMENT:ELEMENT_OPTION:ENCRYPT:LOV:LOV_REQUIRED:LOV_DISPLAY_NULL'
 ,p_sql_min_column_count => 3
 ,p_sql_max_column_count => 3
 ,p_sql_examples => '<pre>'||unistr('\000a')||
'select e.ename as d,'||unistr('\000a')||
'       e.empno as r,'||unistr('\000a')||
'       d.dname as grp'||unistr('\000a')||
'  from emp e,'||unistr('\000a')||
'       dept d'||unistr('\000a')||
' where d.deptno = e.deptno'||unistr('\000a')||
' order by grp, d'||unistr('\000a')||
'</pre>'
 ,p_substitute_attributes => true
 ,p_help_text => '<p>'||unistr('\000a')||
'	<strong>Group Select List</strong> is a replacement for the built-in select list. It provides the possibility to group the entries of the select list.</p>'||unistr('\000a')||
'<p>'||unistr('\000a')||
'	This is done by adding a third column, the &quot;group column&quot; to the &quot;List of Values SQL Statement&quot;. Don&#39;t forget to order the result of your List of Values by the group column and then by the display column. For details have a look at the &quot;List of Values Examples&quot;.</p>'||unistr('\000a')||
''
 ,p_version_identifier => '1.1'
 ,p_about_url => 'http://apex.oracle.com/plugins'
  );
null;
 
end;
/

commit;
begin 
execute immediate 'begin dbms_session.set_nls( param => ''NLS_NUMERIC_CHARACTERS'', value => '''''''' || replace(wwv_flow_api.g_nls_numeric_chars,'''''''','''''''''''') || ''''''''); end;';
end;
/
set verify on
set feedback on
set define on
prompt  ...done

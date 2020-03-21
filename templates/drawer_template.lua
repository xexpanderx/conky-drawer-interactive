require 'cairo'

function hex2rgb(hex)
	hex = hex:gsub("#","")
	return (tonumber("0x"..hex:sub(1,2))/255), (tonumber("0x"..hex:sub(3,4))/255), tonumber(("0x"..hex:sub(5,6))/255)
end

-- HTML colors
black="#000000"
COLORFIELD
function fix_text(text)
	if string.len(text) == 1 then
		new_text = "0" .. text .. "%"
		return new_text
	else
		new_text = text .. "%"
		return new_text
	end
end

function draw_background(cr, w, h)
    cairo_set_line_cap (cr, CAIRO_LINE_CAP_ROUND)
    --Top
	cairo_set_source_rgba(cr, r0, g0, b0, t0_top)
	cairo_arc(cr,w-(w-32),24,24,90*math.pi/180,270*math.pi/180)
	cairo_rel_line_to(cr,w-28,0)
	cairo_arc(cr,w-32,24,24,270*math.pi/180,90*math.pi/180)
	cairo_close_path(cr)
    cairo_fill(cr)
    --Top border
    cairo_set_operator(cr,CAIRO_OPERATOR_SOURCE)
    cairo_set_source_rgba(cr, r, g, b, t_top_border)
	cairo_arc(cr,w-(w-32),24,24,90*math.pi/180,270*math.pi/180)
	cairo_rel_line_to(cr,w-28,0)
	cairo_arc(cr,w-32,24,24,270*math.pi/180,90*math.pi/180)
	cairo_close_path(cr)
    cairo_stroke(cr)
    --Top hole
    cairo_set_source_rgba(cr, r, g, b, t_top_hole)
    cairo_set_line_width(cr, 4)
    cairo_move_to(cr,w-(w-32),24)
    cairo_rel_line_to(cr,w-64,0)
    cairo_stroke(cr)
    --Drawer
    drawer_width=38
    drawer_height=164
    cairo_set_operator(cr,CAIRO_OPERATOR_OVER)
    cairo_set_line_width(cr, 2)
    cairo_set_source_rgba(cr, r0, g0, b0, t0_drawer)
    cairo_move_to(cr,w-(w-drawer_width),24)
    cairo_rel_line_to(cr,0,h-drawer_height)
    z=-1
    for i=0, ((w-64)-12)/4 do
		cairo_rel_line_to(cr,4,4*z)
		z = z * -1
    end
    cairo_rel_line_to(cr,0,-(h-drawer_height))
    cairo_close_path(cr)
    cairo_fill(cr)
    --Drawer border
    cairo_set_line_width(cr, 2)
    cairo_set_source_rgba(cr, r, g, b, t0_drawer_border)
    cairo_move_to(cr,w-(w-drawer_width),24)
    cairo_rel_line_to(cr,0,h-drawer_height)
    z=-1
    for i=0, ((w-64)-12)/4 do
		cairo_rel_line_to(cr,4,4*z)
		z = z * -1
    end
    cairo_rel_line_to(cr,0,-(h-drawer_height))
    cairo_close_path(cr)
    cairo_stroke(cr)
    --Clock
    cairo_select_font_face (cr, "Dejavu Sans Book", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL)
    cairo_set_source_rgba(cr, r7, g7, b7, t7)
	cairo_set_font_size(cr, 24)
	ct = cairo_text_extents_t:create()
	cairo_text_extents(cr,conky_parse('${exec date +%H:%M}'),ct)
	cairo_move_to(cr,w-127,76)
	cairo_show_text(cr,conky_parse('${exec date +%H:%M}'))
	--Date
	cairo_set_font_size(cr, 16)
	ct = cairo_text_extents_t:create()
	cairo_text_extents(cr,conky_parse('${exec date +"%A - %d %B"}'),ct)
	cairo_move_to(cr,60,102)
	cairo_show_text(cr,conky_parse('${exec date +"%A - %d %B"}'))
	--Uptime
	uptime = conky_parse('${uptime}')
	cairo_set_font_size(cr, 12)
	ct = cairo_text_extents_t:create()
	cairo_text_extents(cr,"Uptime: " .. uptime,ct)
	cairo_move_to(cr,60,130)
	cairo_show_text(cr,"Uptime: " .. uptime)
	--CPU
	----Border
	cpu_x = 70
	cpu_y = 180
	cpu_move = 30
	cairo_set_source_rgba(cr, r1, g1, b1, t1)
    cairo_set_line_width(cr, 2)
    cairo_move_to(cr,cpu_x ,cpu_y)
	cairo_rel_line_to(cr,cpu_move,0)
	cairo_rel_line_to(cr,0,cpu_move)
	cairo_rel_line_to(cr,-cpu_move,0)
	cairo_set_line_join (cr, CAIRO_LINE_JOIN_ROUND);
    cairo_close_path(cr)
    cairo_stroke(cr)
    ----CPU hole
	cairo_arc(cr,cpu_x+5,cpu_y+5,2,0*math.pi/180,360*math.pi/180)
    cairo_fill(cr)
    ----Top pins
	cairo_set_line_width(cr, 2)
	cairo_set_line_join (cr, CAIRO_LINE_JOIN_MITER)
    for i=0, 4 do
		cairo_move_to(cr,cpu_x+3+6*i,cpu_y-5)
		cairo_rel_line_to(cr,0,-5)
		cairo_close_path(cr)
		cairo_stroke(cr)
    end
    ----Left pins
    for i=0, 4 do
		cairo_move_to(cr,cpu_x-5,cpu_y+3+6*i)
		cairo_rel_line_to(cr,-5,0)
		cairo_close_path(cr)
		cairo_stroke(cr)
    end
    --Right pins
    for i=0, 4 do
		cairo_move_to(cr,cpu_x+cpu_move+5+5,cpu_y+3+6*i)
		cairo_rel_line_to(cr,-5,0)
		cairo_close_path(cr)
		cairo_stroke(cr)
    end
    --Bottom pins
    for i=0, 4 do
		cairo_move_to(cr,cpu_x+3+6*i,cpu_y+cpu_move+5+5)
		cairo_rel_line_to(cr,0,-5)
		cairo_close_path(cr)
		cairo_stroke(cr)
    end
    for i=0, 10 do
    cairo_set_source_rgba(cr, r7, g7, b7, t7_indicator)
    cairo_arc(cr,cpu_x+cpu_move/2+47+20*i,cpu_y+cpu_move/2,6,0*math.pi/180,360*math.pi/180)
    cairo_fill(cr)
    end
    cpu_used = math.floor(10*tonumber(conky_parse("${cpu cpu0}"))/100)
    for i=0, cpu_used do
    cairo_set_source_rgba(cr, r1, g1, b1, t1)
    cairo_arc(cr,cpu_x+cpu_move/2+47+20*i,cpu_y+cpu_move/2,6,0*math.pi/180,360*math.pi/180)
    cairo_fill(cr)
    end
    --RAM structure
    cairo_set_source_rgba(cr, r2, g2, b2, t2)
    ram_x = 70
	ram_y = 240
	ram_move = 10
	cairo_move_to(cr,ram_x,ram_y)
	cairo_rel_line_to(cr,ram_move,0)
	cairo_rel_line_to(cr,-ram_move,0)
	cairo_rel_line_to(cr,0,48)
    cairo_stroke(cr)
    ----Right-circle
    cairo_arc(cr, ram_x+ram_move+5, ram_y, 4, 0*math.pi/180,180*math.pi/180)
    cairo_stroke(cr)
    --RAM structure 2
    cairo_move_to(cr,ram_x+ram_move+10,ram_y)
    cairo_rel_line_to(cr,10,0)
    cairo_rel_line_to(cr,0,10)
    cairo_rel_line_to(cr,-5,0)
    cairo_stroke(cr)
    ----Bottom-circle
    cairo_arc(cr, ram_x+ram_move+14, ram_y+14, 4, 90*math.pi/180,270*math.pi/180)
    cairo_stroke(cr)
     --RAM structure 3
    cairo_move_to(cr,ram_x+ram_move+15, ram_y+18)
    cairo_rel_line_to(cr,5,0)
    cairo_rel_line_to(cr,0,30)
    cairo_rel_line_to(cr,-11,0)
    cairo_stroke(cr)
    ----Left-circle
    cairo_arc(cr,ram_x+ram_move+5, ram_y+47, 4, 180*math.pi/180,0*math.pi/180)
    cairo_stroke(cr)
    --RAM structure 4 
    cairo_move_to(cr,ram_x+ram_move+1,ram_y+48)
    cairo_rel_line_to(cr,-10,0)
    cairo_stroke(cr)
    ----Pins-left
    for i=1, 4 do
		cairo_move_to(cr,ram_x+ram_move+18,ram_y+18+5*i)
		cairo_rel_line_to(cr,-4,0)
		cairo_stroke(cr)
    end
     ----Pins-right
	cairo_move_to(cr,ram_x+ram_move+18,ram_y+5)
	cairo_rel_line_to(cr,-4,0)
	cairo_stroke(cr)
    ----Left-squares
    cairo_rectangle (cr, ram_x+4, ram_y+35, 8,4);
    cairo_fill(cr)
    cairo_rectangle (cr, ram_x+4, ram_y+29, 8,4);
    cairo_fill(cr)  
    ----Right-squares
    cairo_rectangle (cr, ram_x+4, ram_y+8, 8, 4);
    cairo_fill(cr)
    cairo_rectangle (cr, ram_x+4, ram_y+14, 8, 4);
    cairo_fill(cr)
    for i=0, 10 do
    cairo_set_source_rgba(cr, r7, g7, b7, t7_indicator)
    cairo_arc(cr,ram_x+ram_move/2+57+20*i,ram_y+ram_move/2+19,6,0*math.pi/180,360*math.pi/180)
    cairo_fill(cr)
    end
    mem_used = math.floor(10*tonumber(conky_parse("${memperc}"))/100)
    for i=0, mem_used do
    cairo_set_source_rgba(cr, r2, g2, b2, t2)
    cairo_arc(cr,ram_x+ram_move/2+57+20*i,ram_y+ram_move/2+19,6,0*math.pi/180,360*math.pi/180)
    cairo_fill(cr)
    end
    --HDD
    hdd_x = 75
	hdd_y = 324
	hdd_move = 10
    cairo_set_source_rgba(cr, r3, g3, b3, t3)
	cairo_set_line_width(cr, 2)
	cairo_arc(cr, hdd_x, hdd_y-5,10,180*math.pi/180,270*math.pi/180)
	cairo_rel_line_to(cr,22,0)
	cairo_arc(cr,hdd_x+22, hdd_y-5,10,270*math.pi/180,360*math.pi/180)
	cairo_arc(cr, hdd_x+22, hdd_y-5+28,10,0*math.pi/180,90*math.pi/180)
	cairo_rel_line_to(cr,0,-10)
	cairo_rel_line_to(cr,-22,0)
	cairo_rel_line_to(cr,0,10)
	cairo_arc(cr, hdd_x, hdd_y-5+28,10,90*math.pi/180,180*math.pi/180)
	cairo_close_path(cr)
	cairo_stroke(cr)
	----Holes
	cairo_arc(cr,hdd_x-5,hdd_y+26,2,0*math.pi/180,360*math.pi/180)
	cairo_arc(cr,hdd_x+27,hdd_y+26,2,0*math.pi/180,360*math.pi/180)
	cairo_fill(cr)
	cairo_arc(cr,hdd_x-5,hdd_y-8,2,0*math.pi/180,360*math.pi/180)
	cairo_arc(cr,hdd_x+27,hdd_y-8,2,0*math.pi/180,360*math.pi/180)
	cairo_fill(cr)
	---Rectangle
	cairo_rectangle (cr, hdd_x-5, hdd_y-1, 32, 16);
	cairo_stroke(cr)
	----HDD pins
	cairo_set_line_width(cr, 1)
	for i=0, 2 do
		cairo_rectangle (cr,hdd_x+3.5+6*i,hdd_y+26.5, 3, 7);
		cairo_stroke(cr)
    end
	--Pathname
	cairo_set_font_size(cr, 9)
	cairo_set_source_rgba(cr, r8, g8, b8, t8)
	ct = cairo_text_extents_t:create()
	cairo_text_extents(cr,"Root",ct)
    cairo_move_to(cr,hdd_x+11-ct.width/2,hdd_y+6+ct.height/2)
    cairo_show_text(cr,"Root")
    ---Hdd indicator
    fs_used = math.floor(4*tonumber(conky_parse("${fs_used_perc " .. "/" .. "}"))/100)
    for i=0, 10 do
    cairo_set_source_rgba(cr, r7, g7, b7, t7_indicator)
    cairo_arc(cr,hdd_x+hdd_move/2+52+20*i,hdd_y+hdd_move/2+4,6,0*math.pi/180,360*math.pi/180)
    cairo_fill(cr)
    end
    for i=0, fs_used do
    cairo_set_source_rgba(cr, r3, g3, b3, t3)
    cairo_arc(cr,hdd_x+hdd_move/2+52+20*i,hdd_y+hdd_move/2+4,6,0*math.pi/180,360*math.pi/180)
    cairo_fill(cr)
    end
    --Battery
 	cairo_set_source_rgba(cr, r4, g4, b4, t4)
	cairo_set_line_width(cr, 2)
	--Battery structure
	bat_x = 70
	bat_y = 386
	bat_move = 9
	bat_move_y=4
	cairo_move_to(cr,bat_x,bat_y)
	cairo_rel_line_to(cr,30,0)
	cairo_rel_line_to(cr,0,40)
	cairo_rel_line_to(cr,-30,0)
	cairo_close_path(cr)
	cairo_stroke(cr)
	----Top
	cairo_set_line_width(cr, 2)
	cairo_move_to(cr,bat_x+bat_move,bat_y-bat_move_y)
	cairo_rel_line_to(cr,0,5)
	cairo_arc(cr,bat_x+bat_move+4,bat_y-bat_move_y,4,180*math.pi/180,270*math.pi/180)
	cairo_rel_line_to(cr,6,0)
	cairo_arc(cr,bat_x+bat_move+8,bat_y-bat_move_y,4,270*math.pi/180,0*math.pi/180)
	cairo_rel_line_to(cr,0,4)
	cairo_stroke(cr)
	--Indicators
	battery_status = conky_parse("${battery_short}")
	battery_status = string.sub(battery_status,1,1)
    battery_percentage = math.floor(10*tonumber(conky_parse("${battery_percent}"))/100)
    for i=0, 10 do
    cairo_set_source_rgba(cr, r7, g7, b7, t7_indicator)
    cairo_arc(cr,bat_x+bat_move/2+58+20*i,bat_y+bat_move/2+12,6,0*math.pi/180,360*math.pi/180)
    cairo_fill(cr)
    end
    for i=0, battery_percentage do
    cairo_set_source_rgba(cr, r4, g4, b4, t4)
    cairo_arc(cr,bat_x+bat_move/2+58+20*i,bat_y+bat_move/2+12,6,0*math.pi/180,360*math.pi/180)
    cairo_fill(cr)
    end
    
    
	if battery_status == "C" or battery_status == "F" then
	    cairo_set_source_rgba(cr, r4, g4, b4, t4)
		for i=0,2 do
			cairo_rectangle (cr, bat_x+4.5, bat_y+31-8*i, 21,4);
			cairo_fill(cr)
		end
	elseif battery_status == "D" then
		    cairo_set_source_rgba(cr, r8, g8, b8, t8)
		for i=0,2 do
			cairo_rectangle (cr, bat_x+4.5, bat_y+31-8*i, 21,4);
			cairo_fill(cr)
		end
	else
		cairo_set_source_rgba(cr, r7, g7, b7, t7)
		ct = cairo_text_extents_t:create()
		status=conky_parse("${battery}")
		cairo_text_extents(cr,status,ct)
		cairo_move_to(cr,w/2-ct.width/2+20,h/2+ct.height/2+120)
		cairo_show_text(cr,status)
	end
end


function draw_widgets(cr)
	local w,h=conky_window.width,conky_window.height
	cairo_select_font_face (cr, "Dejavu Sans", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL)
	cairo_set_font_size(cr, 12)
	r0, g0, b0 = hex2rgb(color0)
	r1, g1, b1 = hex2rgb(color1)
	r2, g2, b2 = hex2rgb(color2)
	r3, g3, b3 = hex2rgb(color3)
	r4, g4, b4 = hex2rgb(color4)
	r5, g5, b5 = hex2rgb(color5)
	r6, g6, b6 = hex2rgb(color6)
	r7, g7, b7 = hex2rgb(color7)
	r8, g8, b8 = hex2rgb(color8)
	r, g, b = hex2rgb(black)
	--Get coordinates of conky window and mouse
	x=tonumber(conky_parse("${exec xdotool search --name conky-drawer | sed -n 1p | xargs xdotool getwindowgeometry --shell | grep 'X' | tr -d 'X='}"))
	x_max = x+w
	y=tonumber(conky_parse("${exec xdotool search --name conky-drawer | sed -n 1p | xargs xdotool getwindowgeometry --shell | grep 'Y' | tr -d 'Y='}"))
	y_max = y+48
	mouse_x = tonumber(conky_parse("${exec xdotool getmouselocation --shell | grep 'X' | tr -d 'X='}"))
	mouse_y = tonumber(conky_parse("${exec xdotool getmouselocation --shell | grep 'Y' | tr -d 'Y='}"))
	--Draw background
	if mouse_x > x and mouse_x < x_max and mouse_y > y and mouse_y < y_max then
		t0_top=0.5
		t_top_border=0.2
		t_top_hole=0.5
		t0_drawer=1
		t0_drawer_border=0.2
		t1=1
		t2=1
		t3=1
		t4=1
		t5=1
		t6=1
		t7=1
		t7_indicator=0.2
		t8=1
	else
		t0_top=0.2
		t0_drawer=0
		t0_drawer_border=0.0
		t1=0
		t2=0
		t3=0
		t4=0
		t5=0
		t6=0
		t7=0
		t7_indicator=0.0
		t8=0
		t_top_border=0.0
		t_top_hole=0.3
	end
	draw_background(cr, w, h)
end

function conky_start_widgets()

	if conky_window==nil then return end
	local cs=cairo_xlib_surface_create(conky_window.display,conky_window.drawable,conky_window.visual, conky_window.width,conky_window.height)
	local cr=cairo_create(cs)	
	local ok, err = pcall(function () draw_widgets(cr) end)
	cairo_surface_destroy(cs)
	cairo_destroy(cr)
end

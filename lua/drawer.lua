require 'cairo'

function hex2rgb(hex)
	hex = hex:gsub("#","")
	return (tonumber("0x"..hex:sub(1,2))/255), (tonumber("0x"..hex:sub(3,4))/255), tonumber(("0x"..hex:sub(5,6))/255)
end

-- HTML colors
black="#000000"
color0="#1B0B10"
color1="#B23C4B"
color2="#A23662"
color3="#9D5C6A"
color4="#F05F60"
color5="#F49158"
color6="#FB9173"
color7="#f4cdb1"
color8="#aa8f7b"
color9="#B23C4B"
color10="#A23662"
color11="#9D5C6A"
color12="#F05F60"
color13="#F49158"
color14="#FB9173"
color15="#f4cdb1"
color66="#1b0b10"

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
    cairo_set_operator(cr,CAIRO_OPERATOR_OVER)
    cairo_set_line_width(cr, 2)
    cairo_set_source_rgba(cr, r0, g0, b0, t0_drawer)
    cairo_move_to(cr,w-(w-38),24)
    cairo_rel_line_to(cr,0,h-24)
    z=-1
    for i=0, ((w-64)-12)/4 do
		cairo_rel_line_to(cr,4,4*z)
		z = z * -1
    end
    cairo_rel_line_to(cr,0,-(h-24))
    cairo_close_path(cr)
    cairo_fill(cr)
    --Drawer border
    cairo_set_line_width(cr, 2)
    cairo_set_source_rgba(cr, r, g, b, t0_drawer_border)
    cairo_move_to(cr,w-(w-38),24)
    cairo_rel_line_to(cr,0,h-24)
    z=-1
    for i=0, ((w-64)-12)/4 do
		cairo_rel_line_to(cr,4,4*z)
		z = z * -1
    end
    cairo_rel_line_to(cr,0,-(h-24))
    cairo_close_path(cr)
    cairo_stroke(cr)
    
end

function draw_drawer(cr, w, h)
	local c1=66
	local c2_x=(w-c1)/2
	local c2_y=(h-c1)/2
	local c3_x=w/2
	local c3_y=h/2
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
		t0_top=0.2
		t0_drawer=1
		t0_drawer_border=0.2
		t1=1
		t2=1
		t3=1
		t4=1
		t5=1
		t6=1
		t7=1
		t8=1
		t_top_border=0.0
		t_top_hole=0.5
	else
		t0_top=0.2
		t0_drawer=0
		t0_drawer_border=0
		t1=1
		t2=1
		t3=1
		t4=1
		t5=1
		t6=1
		t7=1
		t8=1
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

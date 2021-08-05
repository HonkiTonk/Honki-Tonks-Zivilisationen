package Test is

   Fenster : sfWindow_Ptr;
   Modus : constant sfVideoMode := (1600, 1000, 32);
   CursorDing : constant sfCursor_Ptr := Cursor.createFromSystem (Cursor.sfCursorHand);
   
   Fenster := create (Modus, "Text");
   setMouseCursor (Fenster, CursorDing);
   setFramerateLimit (Fenster, 30);
   
   while isOpen (Fenster) = True loop
      
      display (Fenster);
      
   end loop;

end Test;

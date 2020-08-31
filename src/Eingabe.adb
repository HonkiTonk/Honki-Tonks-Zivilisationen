package body Eingabe is

   function GanzeZahl return Integer is -- Als String mit Längenbegrenzung, wozu auch Unbounded?
   begin

      Zahl := To_Unbounded_Wide_Wide_String (Get_Line);

      If To_Wide_Wide_String (Zahl)'Length = 1 then
         Text (1) := '0';
         Text (2) := To_Wide_Wide_String (Zahl) (1);
      else
         Text (1) := To_Wide_Wide_String (Zahl) (1);
         Text (2) := To_Wide_Wide_String (Zahl) (2);
      end if;
      
      for A in Text'Range loop
         if Text (A) = '0' or Text (A) = '1' or Text (A) = '2' or Text (A) = '3' or Text (A) = '4' or Text (A) = '5' or Text (A) = '6' or Text (A) = '7' or Text (A) = '8' or Text (A) = '9' then
            null;
         else
            return -1;
         end if;
      end loop;
      
      return Integer'Wide_Wide_Value (Text);
      
   end GanzeZahl;



   function StadtName return Unbounded_Wide_Wide_String is
   begin
      
      Put_Line ("Namen der Stadt eingeben:");
      Name := To_Unbounded_Wide_Wide_String (Get_Line);
      
      return Name;
        
   end StadtName;

end Eingabe;

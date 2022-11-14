with TastenbelegungVariablen;

with NachLogiktask;
with EingabeAllgemeinLogik;
with NachGrafiktask;

package body TasteneingabeLogik is
   
   function VereinfachteEingabe
     return TastenbelegungDatentypen.Allgemeine_Belegung_Enum
   is
      use type Sf.Window.Mouse.sfMouseButton;
      use type Sf.Window.Keyboard.sfKeyCode;
   begin
      
      NachLogiktask.Warten := True;
      NachGrafiktask.TastenEingabe := True;
      
      EingabeAllgemeinLogik.EingabeAbwarten;
      
      Maustaste := NachLogiktask.MausTaste;
      Taste := NachLogiktask.TastaturTaste;
      
      if
        Maustaste = Sf.Window.Mouse.sfMouseLeft
        or
          (Taste /= Sf.Window.Keyboard.sfKeyUnknown
          and
            Taste = TastenbelegungVariablen.AllgemeineBelegung (TastenbelegungDatentypen.Auswählen_Enum))
      then
         return TastenbelegungDatentypen.Auswählen_Enum;
         
      elsif
        Maustaste = Sf.Window.Mouse.sfMouseRight
        or
          (Taste /= Sf.Window.Keyboard.sfKeyUnknown
           and
             Taste = TastenbelegungVariablen.AllgemeineBelegung (TastenbelegungDatentypen.Abwählen_Enum))
      then
         return TastenbelegungDatentypen.Abwählen_Enum;
         
      else
         return TastenbelegungDatentypen.Leer_Allgemeine_Belegung_Enum;
      end if;
      
   end VereinfachteEingabe;
   
   
   function AllgemeineTaste
     return TastenbelegungDatentypen.Allgemeine_Belegung_Enum
   is
      use type Sf.Window.Mouse.sfMouseButton;
      use type Sf.Window.Keyboard.sfKeyCode;
   begin
      
      NachLogiktask.Warten := True;
      NachGrafiktask.TastenEingabe := True;
      
      EingabeAllgemeinLogik.EingabeAbwarten;
      
      Maustaste := NachLogiktask.MausTaste;
      Taste := NachLogiktask.TastaturTaste;
      
      if
        Maustaste = Sf.Window.Mouse.sfMouseLeft
      then
         return TastenbelegungDatentypen.Auswählen_Enum;
         
      elsif
        Maustaste = Sf.Window.Mouse.sfMouseRight
      then
         return TastenbelegungDatentypen.Abwählen_Enum;
         
      elsif
        Taste = Sf.Window.Keyboard.sfKeyUnknown
      then
         return TastenbelegungDatentypen.Leer_Allgemeine_Belegung_Enum;
            
      else
         null;
      end if;
      
      BelegungSchleife:
      for BelegungSchleifenwert in TastenbelegungVariablen.AllgemeineBelegungArray'Range loop
            
         if
           TastenbelegungVariablen.AllgemeineBelegung (BelegungSchleifenwert) = Taste
         then
            return BelegungSchleifenwert;
               
         else
            null;
         end if;
            
      end loop BelegungSchleife;
      
      return TastenbelegungDatentypen.Leer_Allgemeine_Belegung_Enum;
      
   end AllgemeineTaste;
   
   
   
   function Einheitentaste
     return BefehleDatentypen.Einheitenbelegung_Enum
   is
      use type Sf.Window.Mouse.sfMouseButton;
      use type Sf.Window.Keyboard.sfKeyCode;
   begin
      
      NachLogiktask.Warten := True;
      NachGrafiktask.TastenEingabe := True;
      
      EingabeAllgemeinLogik.EingabeAbwarten;
      
      Maustaste := NachLogiktask.MausTaste;
      Taste := NachLogiktask.TastaturTaste;
      
      if
        Maustaste = Sf.Window.Mouse.sfMouseLeft
      then
         return BefehleDatentypen.Auswählen_Enum;
         
      elsif
        Maustaste = Sf.Window.Mouse.sfMouseRight
      then
         return BefehleDatentypen.Abwählen_Enum;
         
      elsif
        Taste = Sf.Window.Keyboard.sfKeyUnknown
      then
         return BefehleDatentypen.Leer_Einheitenbelegung_Enum;
            
      else
         null;
      end if;
      
      BelegungSchleife:
      for BelegungSchleifenwert in TastenbelegungVariablen.EinheitenbelegungArray'Range loop
            
         if
           TastenbelegungVariablen.Einheitenbelegung (BelegungSchleifenwert) = Taste
         then
            return BelegungSchleifenwert;
               
         else
            null;
         end if;
            
      end loop BelegungSchleife;
            
      return BefehleDatentypen.Leer_Einheitenbelegung_Enum;
        
   end Einheitentaste;
   
   
   
   function Stadttaste
     return BefehleDatentypen.Stadtbefehle_Enum
   is
      use type Sf.Window.Mouse.sfMouseButton;
      use type Sf.Window.Keyboard.sfKeyCode;
   begin
      
      NachLogiktask.Warten := True;
      NachGrafiktask.TastenEingabe := True;
      
      EingabeAllgemeinLogik.EingabeAbwarten;
      
      Maustaste := NachLogiktask.MausTaste;
      Taste := NachLogiktask.TastaturTaste;
      
      if
        Maustaste = Sf.Window.Mouse.sfMouseLeft
      then
         return BefehleDatentypen.Auswählen_Enum;
         
      elsif
        Maustaste = Sf.Window.Mouse.sfMouseRight
      then
         return BefehleDatentypen.Verlassen_Enum;
         
      elsif
        Taste = Sf.Window.Keyboard.sfKeyUnknown
      then
         return BefehleDatentypen.Leer_Stadtbefehle_Enum;
            
      else
         null;
      end if;
      
      BelegungSchleife:
      for BelegungSchleifenwert in TastenbelegungVariablen.StadtbelegungArray'Range loop
            
         if
           TastenbelegungVariablen.Stadtbelegung (BelegungSchleifenwert) = Taste
         then
            return BelegungSchleifenwert;
               
         else
            null;
         end if;
            
      end loop BelegungSchleife;
            
      return BefehleDatentypen.Leer_Stadtbefehle_Enum;
      
   end Stadttaste;
   
   

   function TastenbelegungAnpassen
     return Sf.Window.Keyboard.sfKeyCode
   is begin
      
      TasteneingabeSchleife:
      loop
         
         NachLogiktask.Warten := True;
         NachGrafiktask.TastenEingabe := True;
         
         EingabeAllgemeinLogik.EingabeAbwarten;
      
         Maustaste := NachLogiktask.MausTaste;
         
         case
           Maustaste
         is
            when Sf.Window.Mouse.sfMouseRight =>
               return Sf.Window.Keyboard.sfKeyUnknown;
            
            when others =>
               Taste := NachLogiktask.TastaturTaste;
         end case;
      
         case
           Taste
         is
            when Sf.Window.Keyboard.sfKeyEscape =>
               return Sf.Window.Keyboard.sfKeyUnknown;
               
            when Sf.Window.Keyboard.sfKeyUnknown =>
               null;
               
            when others =>
               return Taste;
         end case;
         
      end loop TasteneingabeSchleife;
      
   end TastenbelegungAnpassen;

end TasteneingabeLogik;

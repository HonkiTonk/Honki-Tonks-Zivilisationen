with LeseTastenbelegungDatenbank;
with SchreibeLogiktask;
with LeseLogiktask;
with SchreibeGrafiktask;

with EingabeAllgemeinLogik;

package body TasteneingabeLogik is
   
   function EingabeanfangSetzen
     return TastenRecord
   is begin
      
      SchreibeLogiktask.WartenGrafik (ZustandExtern => True);
      SchreibeGrafiktask.Tasteneingabe (JaNeinExtern => True);
      
      EingabeAllgemeinLogik.EingabeAbwarten;
      
      return (LeseLogiktask.Maustaste, LeseLogiktask.Tastaturtaste);
      
   end EingabeanfangSetzen;
   
   
   
   function VereinfachteEingabe
     return TastenbelegungDatentypen.Allgemeine_Belegung_Enum
   is
      use type Sf.Window.Mouse.sfMouseButton;
      use type Sf.Window.Keyboard.sfKeyCode;
   begin
      
      VereinfachteEingabeTasten := EingabeanfangSetzen;
      
      if
        VereinfachteEingabeTasten.Maustaste = Sf.Window.Mouse.sfMouseLeft
        or
          (VereinfachteEingabeTasten.Tastaturtaste /= Sf.Window.Keyboard.sfKeyUnknown
           and
             VereinfachteEingabeTasten.Tastaturtaste = LeseTastenbelegungDatenbank.AllgemeineBelegung (BefehlExtern => TastenbelegungDatentypen.Auswählen_Enum))
      then
         return TastenbelegungDatentypen.Auswählen_Enum;
         
      elsif
        VereinfachteEingabeTasten.Maustaste = Sf.Window.Mouse.sfMouseRight
        or
          (VereinfachteEingabeTasten.Tastaturtaste /= Sf.Window.Keyboard.sfKeyUnknown
           and
             VereinfachteEingabeTasten.Tastaturtaste = LeseTastenbelegungDatenbank.AllgemeineBelegung (BefehlExtern => TastenbelegungDatentypen.Abwählen_Enum))
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
      
      AllgemeineTasteTasten := EingabeanfangSetzen;
      
      if
        AllgemeineTasteTasten.Maustaste = Sf.Window.Mouse.sfMouseLeft
      then
         return TastenbelegungDatentypen.Auswählen_Enum;
         
      elsif
        AllgemeineTasteTasten.Maustaste = Sf.Window.Mouse.sfMouseRight
      then
         return TastenbelegungDatentypen.Abwählen_Enum;
         
      elsif
        AllgemeineTasteTasten.Tastaturtaste = Sf.Window.Keyboard.sfKeyUnknown
      then
         return TastenbelegungDatentypen.Leer_Allgemeine_Belegung_Enum;
            
      else
         null;
      end if;
      
      AllgemeineBelegungSchleife:
      for AllgemeineBelegungSchleifenwert in TastenbelegungDatentypen.Allgemeine_Belegung_Vorhanden_Enum'Range loop
            
         if
           LeseTastenbelegungDatenbank.AllgemeineBelegung (BefehlExtern => AllgemeineBelegungSchleifenwert) = AllgemeineTasteTasten.Tastaturtaste
         then
            return AllgemeineBelegungSchleifenwert;
               
         else
            null;
         end if;
         
      end loop AllgemeineBelegungSchleife;
      
      return TastenbelegungDatentypen.Leer_Allgemeine_Belegung_Enum;
      
   end AllgemeineTaste;
   
   
   
   function Einheitentaste
     return BefehleDatentypen.Einheitenbelegung_Enum
   is
      use type Sf.Window.Mouse.sfMouseButton;
      use type Sf.Window.Keyboard.sfKeyCode;
   begin
      
      EinheitentasteTasten := EingabeanfangSetzen;
      
      if
        EinheitentasteTasten.Maustaste = Sf.Window.Mouse.sfMouseLeft
      then
         return BefehleDatentypen.Auswählen_Enum;
         
      elsif
        EinheitentasteTasten.Maustaste = Sf.Window.Mouse.sfMouseRight
      then
         return BefehleDatentypen.Abwählen_Enum;
         
      elsif
        EinheitentasteTasten.Tastaturtaste = Sf.Window.Keyboard.sfKeyUnknown
      then
         return BefehleDatentypen.Leer_Einheitenbelegung_Enum;
            
      else
         null;
      end if;
      
      EinheitenbelegungSchleife:
      for EinheitenbelegungSchleifenwert in BefehleDatentypen.Einheitenbelegung_Vorhanden_Enum'Range loop
            
         if
           LeseTastenbelegungDatenbank.Einheitenbelegung (BefehlExtern => EinheitenbelegungSchleifenwert) = EinheitentasteTasten.Tastaturtaste
         then
            return EinheitenbelegungSchleifenwert;
               
         else
            null;
         end if;
            
      end loop EinheitenbelegungSchleife;
            
      return BefehleDatentypen.Leer_Einheitenbelegung_Enum;
        
   end Einheitentaste;
   
   
   
   function Stadttaste
     return BefehleDatentypen.Stadtbefehle_Enum
   is
      use type Sf.Window.Mouse.sfMouseButton;
      use type Sf.Window.Keyboard.sfKeyCode;
   begin
      
      StadttasteTasten := EingabeanfangSetzen;
      
      if
        StadttasteTasten.Maustaste = Sf.Window.Mouse.sfMouseLeft
      then
         return BefehleDatentypen.Auswählen_Enum;
         
      elsif
        StadttasteTasten.Maustaste = Sf.Window.Mouse.sfMouseRight
      then
         return BefehleDatentypen.Verlassen_Enum;
         
      elsif
        StadttasteTasten.Tastaturtaste = Sf.Window.Keyboard.sfKeyUnknown
      then
         return BefehleDatentypen.Leer_Stadtbefehle_Enum;
            
      else
         null;
      end if;
      
      StadtbelegungSchleife:
      for StadtbelegungSchleifenwert in BefehleDatentypen.Stadtbefehle_Auswählen_Enum'Range loop
            
         if
           LeseTastenbelegungDatenbank.Stadtbelegung (BefehlExtern => StadtbelegungSchleifenwert) = StadttasteTasten.Tastaturtaste
         then
            return StadtbelegungSchleifenwert;
               
         else
            null;
         end if;
            
      end loop StadtbelegungSchleife;
            
      return BefehleDatentypen.Leer_Stadtbefehle_Enum;
      
   end Stadttaste;
   
   

   function TastenbelegungAnpassen
     return Sf.Window.Keyboard.sfKeyCode
   is begin
      
      TasteneingabeSchleife:
      loop
         
         TastenbelegungAnpassenTasten := EingabeanfangSetzen;
         
         -- SchreibeLogiktask.WartenGrafik (ZustandExtern => True);
         -- SchreibeGrafiktask.Tasteneingabe (JaNeinExtern => True);
         
         -- EingabeAllgemeinLogik.EingabeAbwarten;
      
         -- Maustaste := LeseLogiktask.Maustaste;
         
         case
           TastenbelegungAnpassenTasten.Maustaste
         is
            when Sf.Window.Mouse.sfMouseRight =>
               return Sf.Window.Keyboard.sfKeyUnknown;
            
            when others =>
               null;
         end case;
      
         case
           TastenbelegungAnpassenTasten.Tastaturtaste
         is
            when Sf.Window.Keyboard.sfKeyEscape =>
               return Sf.Window.Keyboard.sfKeyUnknown;
               
            when Sf.Window.Keyboard.sfKeyUnknown =>
               null;
               
            when others =>
               return TastenbelegungAnpassenTasten.Tastaturtaste;
         end case;
         
      end loop TasteneingabeSchleife;
      
   end TastenbelegungAnpassen;

end TasteneingabeLogik;

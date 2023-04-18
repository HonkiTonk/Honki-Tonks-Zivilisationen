with LeseTastenbelegungDatenbank;

with NachLogiktask;
with EingabeAllgemeinLogik;
with NachGrafiktask;

package body TasteneingabeLogik is
   
   procedure EingabeanfangSetzen
   is begin
      
      NachLogiktask.GrafikWarten := True;
      NachGrafiktask.TastenEingabe := True;
      
      EingabeAllgemeinLogik.EingabeAbwarten;
      
      Maustaste := NachLogiktask.MausTaste;
      Taste := NachLogiktask.TastaturTaste;
      
   end EingabeanfangSetzen;
   
   
   
   function VereinfachteEingabe
     return TastenbelegungDatentypen.Allgemeine_Belegung_Enum
   is
      use type Sf.Window.Mouse.sfMouseButton;
      use type Sf.Window.Keyboard.sfKeyCode;
   begin
      
      EingabeanfangSetzen;
      
      if
        Maustaste = Sf.Window.Mouse.sfMouseLeft
        or
          (Taste /= Sf.Window.Keyboard.sfKeyUnknown
           and
             Taste = LeseTastenbelegungDatenbank.AllgemeineBelegung (BefehlExtern => TastenbelegungDatentypen.Auswählen_Enum))
      then
         return TastenbelegungDatentypen.Auswählen_Enum;
         
      elsif
        Maustaste = Sf.Window.Mouse.sfMouseRight
        or
          (Taste /= Sf.Window.Keyboard.sfKeyUnknown
           and
             Taste = LeseTastenbelegungDatenbank.AllgemeineBelegung (BefehlExtern => TastenbelegungDatentypen.Abwählen_Enum))
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
      
      EingabeanfangSetzen;
      
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
      
      AllgemeineBelegungSchleife:
      for AllgemeineBelegungSchleifenwert in TastenbelegungDatentypen.Allgemeine_Belegung_Vorhanden_Enum'Range loop
            
         if
           LeseTastenbelegungDatenbank.AllgemeineBelegung (BefehlExtern => AllgemeineBelegungSchleifenwert) = Taste
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
      
      EingabeanfangSetzen;
      
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
      
      EinheitenbelegungSchleife:
      for EinheitenbelegungSchleifenwert in BefehleDatentypen.Einheitenbelegung_Vorhanden_Enum'Range loop
            
         if
           LeseTastenbelegungDatenbank.Einheitenbelegung (BefehlExtern => EinheitenbelegungSchleifenwert) = Taste
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
      
      EingabeanfangSetzen;
      
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
      
      StadtbelegungSchleife:
      for StadtbelegungSchleifenwert in BefehleDatentypen.Stadtbefehle_Auswählen_Enum'Range loop
            
         if
           LeseTastenbelegungDatenbank.Stadtbelegung (BefehlExtern => StadtbelegungSchleifenwert) = Taste
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
         
         NachLogiktask.GrafikWarten := True;
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

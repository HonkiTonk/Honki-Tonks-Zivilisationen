pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Window.Mouse; use Sf.Window.Mouse;
with Sf.Window.Keyboard; use Sf.Window.Keyboard;

with TastenbelegungVariablen;

with NachLogiktask;
with EingabeAllgemeinLogik;
with NachGrafiktask;

package body TasteneingabeLogik is
   
   function Tastenwert
     return TastenbelegungDatentypen.Tastenbelegung_Enum
   is begin
      
      NachLogiktask.Warten := True;
      NachGrafiktask.TastenEingabe := True;
      
      EingabeAllgemeinLogik.EingabeAbwarten;
      
      Maustaste := NachLogiktask.MausTaste;
      
      if
        Maustaste = Sf.Window.Mouse.sfMouseLeft
      then
         return TastenbelegungDatentypen.Auswählen_Enum;
         
      elsif
        Maustaste = Sf.Window.Mouse.sfMouseRight
      then
         return TastenbelegungDatentypen.Menü_Zurück_Enum;
         
      elsif
        NachLogiktask.TastaturTaste = Sf.Window.Keyboard.sfKeyUnknown
      then
         return TastenbelegungDatentypen.Leer_Tastenbelegung_Enum;
            
      else
         Taste := NachLogiktask.TastaturTaste;
      end if;
      
      BelegungSchleife:
      for BelegungSchleifenwert in TastenbelegungVariablen.TastenbelegungArray'Range loop
            
         if
           TastenbelegungVariablen.Tastenbelegung (BelegungSchleifenwert) = Taste
         then
            return BelegungSchleifenwert;
               
         else
            null;
         end if;
            
      end loop BelegungSchleife;
      
      return TastenbelegungDatentypen.Leer_Tastenbelegung_Enum;
      
   end Tastenwert;
   
   

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
            when Sf.Window.Keyboard.sfKeyNumpad0 .. Sf.Window.Keyboard.sfKeyNumpad9 | Sf.Window.Keyboard.sfKeyAdd .. Sf.Window.Keyboard.sfKeySubtract =>
               null;
            
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

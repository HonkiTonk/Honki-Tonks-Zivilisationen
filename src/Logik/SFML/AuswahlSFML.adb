pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen;
with SystemKonstanten;
with TastenbelegungDatentypen;

with GrafikEinstellungenSFML;
with Eingabe;
with InteraktionAuswahl;
with InteraktionEingabe;

package body AuswahlSFML is

   function AuswahlJaNeinSFML
     (FrageZeileExtern : in Positive)
      return Boolean
   is begin
      
      InteraktionEingabe.JaNeinFrage := FrageZeileExtern;
      InteraktionEingabe.Eingabe := SystemDatentypen.Ja_Nein_Enum;
      
      AuswahlSchleife:
      loop
      
         AktuelleAuswahl := MausAuswahl;
      
         case
           Eingabe.Tastenwert
         is
            when TastenbelegungDatentypen.Auswählen_Enum =>
               if
                 AktuelleAuswahl = SystemKonstanten.LeerAuswahl
               then
                  null;
                  
               else
                  exit AuswahlSchleife;
               end if;
               
            when TastenbelegungDatentypen.Menü_Zurück_Enum =>
               AktuelleAuswahl := SystemKonstanten.LeerAuswahl;
               exit AuswahlSchleife;
            
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
      
      InteraktionEingabe.Eingabe := SystemDatentypen.Keine_Eingabe_Enum;
      InteraktionEingabe.JaNeinFrage := 0;
      
      case
        AktuelleAuswahl
      is
         when 1 =>
            return True;
            
         when others =>
            return False;
      end case;
      
   end AuswahlJaNeinSFML;
   
   
   
   ----------------------- Allgemeiners System für die ganzen MausAuswahlen bauen.
   function MausAuswahl
     return Natural
   is begin
      
      -- Niemals direkt die Mausposition abrufen sondern immer die Werte in der Eingabe ermitteln lassen. Sonst kann es zu einem Absturz kommen.
      MausZeigerPosition := GrafikEinstellungenSFML.MausPosition;
      
      PositionSchleife:
      for PositionSchleifenwert in InteraktionAuswahl.PositionenJaNeinArray'Range loop
         
         if
           MausZeigerPosition.y in Sf.sfInt32 (InteraktionAuswahl.PositionenJaNein (PositionSchleifenwert).top)
             .. Sf.sfInt32 (InteraktionAuswahl.PositionenJaNein (PositionSchleifenwert).top + InteraktionAuswahl.PositionenJaNein (PositionSchleifenwert).height)
             and
               MausZeigerPosition.x in Sf.sfInt32 (InteraktionAuswahl.PositionenJaNein (PositionSchleifenwert).left)
                 .. Sf.sfInt32 (InteraktionAuswahl.PositionenJaNein (PositionSchleifenwert).left + InteraktionAuswahl.PositionenJaNein (PositionSchleifenwert).width)
         then
            return PositionSchleifenwert;
            
         else
            null;
         end if;
         
      end loop PositionSchleife;
      
      return SystemKonstanten.LeerAuswahl;
      
   end MausAuswahl;

end AuswahlSFML;

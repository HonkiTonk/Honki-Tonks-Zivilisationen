pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen;
with SystemKonstanten;
with TastenbelegungDatentypen;

with NachLogiktask;
with Eingabe;
with InteraktionAuswahl;
with NachGrafiktask;

package body AuswahlSFML is

   function AuswahlJaNeinSFML
     (FrageZeileExtern : in Positive)
      return Boolean
   is begin
      
      NachGrafiktask.AnzeigeFrage := FrageZeileExtern;
      NachGrafiktask.Eingabe := SystemDatentypen.Ja_Nein_Enum;
      
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
      
      NachGrafiktask.Eingabe := SystemDatentypen.Keine_Eingabe_Enum;
      NachGrafiktask.AnzeigeFrage := 0;
      
      case
        AktuelleAuswahl
      is
         when 1 =>
            return True;
            
         when others =>
            return False;
      end case;
      
   end AuswahlJaNeinSFML;
   
   
   
   -- Allgemeineres System für die ganzen MausAuswahlen bauen. äöü
   function MausAuswahl
     return Natural
   is begin
      
      Mausposition := NachLogiktask.Mausposition;
      
      PositionSchleife:
      for PositionSchleifenwert in InteraktionAuswahl.PositionenJaNeinArray'Range loop
         
         if
           Mausposition.y in InteraktionAuswahl.PositionenJaNein (PositionSchleifenwert).top
           .. InteraktionAuswahl.PositionenJaNein (PositionSchleifenwert).top + InteraktionAuswahl.PositionenJaNein (PositionSchleifenwert).height
           and
             Mausposition.x in InteraktionAuswahl.PositionenJaNein (PositionSchleifenwert).left
           .. InteraktionAuswahl.PositionenJaNein (PositionSchleifenwert).left + InteraktionAuswahl.PositionenJaNein (PositionSchleifenwert).width
         then
            return PositionSchleifenwert;
            
         else
            null;
         end if;
         
      end loop PositionSchleife;
      
      return SystemKonstanten.LeerAuswahl;
      
   end MausAuswahl;

end AuswahlSFML;

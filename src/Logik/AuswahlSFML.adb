pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.RenderWindow;

with SystemDatentypen;
with SystemKonstanten;
with TastenbelegungDatentypen;
with Views;

with NachLogiktask;
with EingabeSFML;
with InteraktionAuswahl;
with NachGrafiktask;
with GrafikEinstellungenSFML;
with Vergleiche;

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
         NachGrafiktask.AktuelleAuswahl.AuswahlEins := AktuelleAuswahl;
      
         case
           EingabeSFML.Tastenwert
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
   
   
   
   function MausAuswahl
     return Natural
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                                 point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                 view         => Views.FragenviewAccesse (2));
      
      PositionSchleife:
      for PositionSchleifenwert in InteraktionAuswahl.PositionenJaNein'Range loop
         
         case
           Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                       TextboxExtern      => InteraktionAuswahl.PositionenJaNein (PositionSchleifenwert))
         is
            when True =>
               return PositionSchleifenwert;
            
            when False =>
               null;
         end case;
         
      end loop PositionSchleife;
      
      return SystemKonstanten.LeerAuswahl;
      
   end MausAuswahl;

end AuswahlSFML;

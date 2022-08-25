pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Window.Keyboard; use Sf.Window.Keyboard;
with Sf.Graphics.RenderWindow;

with TastenbelegungDatentypen; use TastenbelegungDatentypen;
with InteraktionAuswahl;
with Views;
with MenueDatentypen;
with SystemKonstanten;
with SystemDatentypen;
with TextnummernKonstanten;
with TastenbelegungVariablen;

with NachGrafiktask;
with GrafikEinstellungenSFML;
with EingabeSFML;
with Vergleiche;
with NachLogiktask;
with RueckgabeMenues;

package body AuswahlSteuerungsmenue is
      
   function Auswahl
     return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      AuswahlSchleife:
      loop
         
         AktuelleAuswahl := MausAuswahl;
         NachGrafiktask.AktuelleAuswahl := AktuelleAuswahl;
         
         case
           EingabeSFML.Tastenwert
         is
            when TastenbelegungDatentypen.Auswählen_Enum =>
               if
                 AktuelleAuswahl.AuswahlEins /= 0
               then
                  Rückgabewert := RueckgabeMenues.RückgabeMenüs (AnfangExtern          => InteraktionAuswahl.PositionenSteuerung'First,
                                                                    EndeExtern            => InteraktionAuswahl.PositionenSteuerung'Last,
                                                                    AktuelleAuswahlExtern => AktuelleAuswahl.AuswahlEins,
                                                                    WelchesMenüExtern     => MenueDatentypen.Steuerung_Menü_Enum);
                  exit AuswahlSchleife;
                  
               elsif
                 AktuelleAuswahl.AuswahlZwei /= SystemKonstanten.LeerAuswahl
               then
                  TasteBelegen (AuswahlExtern => AktuelleAuswahl.AuswahlZwei);
                  
               else
                  null;
               end if;
               
            when TastenbelegungDatentypen.Menü_Zurück_Enum =>
               return RueckgabeDatentypen.Zurück_Enum;
               
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
      
      return Rückgabewert;
      
   end Auswahl;
   
         
   
   function MausAuswahl
     return SystemRecords.MehrfacheAuswahlRecord
   is begin
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                                 point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                 view         => Views.SteuerungviewAccesse (1));
      
      BefehleSchleife:
      for BefehleSchleifenwert in InteraktionAuswahl.PositionenSteuerung'Range loop
         
         case
           Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                       TextboxExtern      => InteraktionAuswahl.PositionenSteuerung (BefehleSchleifenwert))
         is
            when True =>
               return (BefehleSchleifenwert, 0);
               
            when False =>
               null;
         end case;
         
      end loop BefehleSchleife;
      
      
      
      Mausposition := Sf.Graphics.RenderWindow.mapPixelToCoords (renderWindow => GrafikEinstellungenSFML.FensterAccess,
                                                                 point        => (Sf.sfInt32 (NachLogiktask.Mausposition.x), Sf.sfInt32 (NachLogiktask.Mausposition.y)),
                                                                 view         => Views.SteuerungviewAccesse (2));
         
      PositionSchleife:
      for PositionSchleifenwert in TastenbelegungDatentypen.Tastenbelegung_Auswählbar_Enum'Range loop
                  
         case
           Vergleiche.Auswahlposition (MauspositionExtern => Mausposition,
                                       TextboxExtern      => InteraktionAuswahl.PositionenSteuerungbelegung (PositionSchleifenwert))
         is
            when True =>
               return (0, TastenbelegungDatentypen.Tastenbelegung_Verwendet_Enum'Pos (PositionSchleifenwert));
               
            when False =>
               null;
         end case;
         
      end loop PositionSchleife;
      
      return (SystemKonstanten.LeerAuswahl, SystemKonstanten.LeerAuswahl);
      
   end MausAuswahl;
   
   
   
   procedure TasteBelegen
     (AuswahlExtern : in Positive)
   is begin
      
      NachGrafiktask.AnzeigeFrage := TextnummernKonstanten.FrageNeueTaste;
      NachGrafiktask.Eingabe := SystemDatentypen.Zeichen_Eingabe_Enum;
      
      NeueTaste := EingabeSFML.TastenbelegungAnpassen;
      
      NachGrafiktask.Eingabe := SystemDatentypen.Keine_Eingabe_Enum;
      
      case
        NeueTaste
      is
         when Sf.Window.Keyboard.sfKeyUnknown =>
            return;
            
         when others =>
            null;
      end case;
      
      TastaturSchleife:
      for TastaturSchleifenwert in TastenbelegungVariablen.TastenbelegungArray'Range loop
         
         if
           TastaturSchleifenwert = TastenbelegungDatentypen.Tastenbelegung_Enum'Val (AuswahlExtern)
         then
            TastenbelegungVariablen.Tastenbelegung (TastaturSchleifenwert) := NeueTaste;
            
         elsif
           TastenbelegungVariablen.Tastenbelegung (TastaturSchleifenwert) = NeueTaste
         then
            TastenbelegungVariablen.Tastenbelegung (TastaturSchleifenwert) := Sf.Window.Keyboard.sfKeyUnknown;
            
         else
            null;
         end if;
         
      end loop TastaturSchleife;
            
   end TasteBelegen;

end AuswahlSteuerungsmenue;

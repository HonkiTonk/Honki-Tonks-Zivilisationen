pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Window.Keyboard; use Sf.Window.Keyboard;

with TastenbelegungDatentypen; use TastenbelegungDatentypen;
with InteraktionAuswahl;
with MenueDatentypen;
with SystemKonstanten;
with SystemDatentypen;
with TextnummernKonstanten;
with TastenbelegungVariablen;

with NachGrafiktask;
with EingabeSFML;
with RueckgabeMenues;
with Mausauswahl;

package body AuswahlSteuerungsmenue is
      
   function Auswahl
     return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      AuswahlSchleife:
      loop
         
         AktuelleAuswahl := Mausauswahl.Steuerung;
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

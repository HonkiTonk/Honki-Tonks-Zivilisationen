pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Window.Keyboard; use Sf.Window.Keyboard;

with TastenbelegungDatentypen; use TastenbelegungDatentypen;
with InteraktionAuswahl;
with SystemKonstanten;
with GrafikDatentypen;
with TextnummernKonstanten;
with TastenbelegungVariablen;

with NachGrafiktask;
with TasteneingabeLogik;
with MenuerueckgabenLogik;
with MausauswahlLogik;

package body SteuerungsauswahlLogik is
      
   function Auswahl
     return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      AuswahlSchleife:
      loop
         
         AktuelleAuswahl := MausauswahlLogik.Steuerung;
         NachGrafiktask.AktuelleAuswahl := AktuelleAuswahl;
         
         case
           TasteneingabeLogik.VereinfachteEingabe
         is
            when TastenbelegungDatentypen.Auswählen_Enum =>
               if
                 AktuelleAuswahl.AuswahlEins /= 0
               then
                  Rückgabewert := MenuerueckgabenLogik.SteuerungMenü (AnfangExtern          => InteraktionAuswahl.PositionenSteuerung'First,
                                                                      EndeExtern            => InteraktionAuswahl.PositionenSteuerung'Last,
                                                                      AktuelleAuswahlExtern => AktuelleAuswahl.AuswahlEins);
                  exit AuswahlSchleife;
                  
               elsif
                 AktuelleAuswahl.AuswahlZwei /= SystemKonstanten.LeerAuswahl
               then
                  TasteBelegen (AuswahlExtern => AktuelleAuswahl.AuswahlZwei);
                  
               else
                  null;
               end if;
               
            when TastenbelegungDatentypen.Abwählen_Enum =>
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
      NachGrafiktask.Eingabe := GrafikDatentypen.Zeichen_Eingabe_Enum;
      
      NeueTaste := TasteneingabeLogik.TastenbelegungAnpassen;
      
      NachGrafiktask.Eingabe := GrafikDatentypen.Keine_Eingabe_Enum;
      
      case
        NeueTaste
      is
         when Sf.Window.Keyboard.sfKeyUnknown =>
            return;
            
         when others =>
            null;
      end case;
      
      TastaturSchleife:
      for TastaturSchleifenwert in TastenbelegungVariablen.AllgemeineBelegungArray'Range loop
         
         if
           TastaturSchleifenwert = TastenbelegungDatentypen.Allgemeine_Belegung_Enum'Val (AuswahlExtern)
         then
            TastenbelegungVariablen.AllgemeineBelegung (TastaturSchleifenwert) := NeueTaste;
            
         elsif
           TastenbelegungVariablen.AllgemeineBelegung (TastaturSchleifenwert) = NeueTaste
         then
            TastenbelegungVariablen.AllgemeineBelegung (TastaturSchleifenwert) := Sf.Window.Keyboard.sfKeyUnknown;
            
         else
            null;
         end if;
         
      end loop TastaturSchleife;
            
   end TasteBelegen;

end SteuerungsauswahlLogik;

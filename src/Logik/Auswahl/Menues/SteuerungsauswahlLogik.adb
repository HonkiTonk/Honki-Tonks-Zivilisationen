pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TastenbelegungDatentypen; use TastenbelegungDatentypen;
with BefehleDatentypen; use BefehleDatentypen;
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
                 AktuelleAuswahl.AuswahlEins = -1
               then
                  WelcheSteuerung := False;
                  
               elsif
                 AktuelleAuswahl.AuswahlZwei = -1
               then
                  WelcheSteuerung := True;
                  
               elsif
                 AktuelleAuswahl.AuswahlEins in SystemKonstanten.AllgemeineSteuerung .. SystemKonstanten.SonstigesSteuerung - 1
               then
                  TasteBelegen (AuswahlExtern         => AktuelleAuswahl.AuswahlEins,
                                WelcheSteuerungExtern => WelcheSteuerung);
                  
               elsif
                 AktuelleAuswahl.AuswahlEins >= SystemKonstanten.SonstigesSteuerung
               then
                  return MenuerueckgabenLogik.SteuerungMenü (AnfangExtern          => SystemKonstanten.SonstigesSteuerung,
                                                              EndeExtern            => InteraktionAuswahl.PositionenSteuerung'Last,
                                                              AktuelleAuswahlExtern => AktuelleAuswahl.AuswahlEins);
                  
               else
                  null;
               end if;
               
            when TastenbelegungDatentypen.Abwählen_Enum =>
               return RueckgabeDatentypen.Zurück_Enum;
               
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
      
   end Auswahl;
   
   
   
   procedure TasteBelegen
     (AuswahlExtern : in Positive;
      WelcheSteuerungExtern : in Boolean)
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
      
      case
        WelcheSteuerungExtern
      is
         when False =>
            AllgemeineBelegung (AuswahlExtern => AuswahlExtern - SystemKonstanten.AllgemeineSteuerungEnumausgleich,
                                TasteExtern   => NeueTaste);
            
         when True =>
            Einheitenbelegung (AuswahlExtern => AuswahlExtern - SystemKonstanten.EinheitensteuerungEnumausgleich,
                               TasteExtern   => NeueTaste);
      end case;
      
   end TasteBelegen;
   
   
   
   procedure AllgemeineBelegung
     (AuswahlExtern : in Positive;
      TasteExtern : in Sf.Window.Keyboard.sfKeyCode)
   is begin
      
      AllgemeineBelegungSchleife:
      for AllgemeineBelegungSchleifenwert in TastenbelegungVariablen.AllgemeineBelegungArray'Range loop
         
         if
           AllgemeineBelegungSchleifenwert = TastenbelegungDatentypen.Allgemeine_Belegung_Enum'Val (AuswahlExtern)
         then
            TastenbelegungVariablen.AllgemeineBelegung (AllgemeineBelegungSchleifenwert) := TasteExtern;
            
         elsif
           TastenbelegungVariablen.AllgemeineBelegung (AllgemeineBelegungSchleifenwert) = TasteExtern
         then
            TastenbelegungVariablen.AllgemeineBelegung (AllgemeineBelegungSchleifenwert) := Sf.Window.Keyboard.sfKeyUnknown;
            
         else
            null;
         end if;
         
      end loop AllgemeineBelegungSchleife;
      
   end AllgemeineBelegung;
   
   
   
   procedure Einheitenbelegung
     (AuswahlExtern : in Positive;
      TasteExtern : in Sf.Window.Keyboard.sfKeyCode)
   is begin
      
      EinheitenbelegungSchleife:
      for EinheitenbelegungSchleifenwert in TastenbelegungVariablen.EinheitenbelegungArray'Range loop
         
         if
           EinheitenbelegungSchleifenwert = BefehleDatentypen.Einheitenbelegung_Enum'Val (AuswahlExtern)
         then
            TastenbelegungVariablen.Einheitenbelegung (EinheitenbelegungSchleifenwert) := TasteExtern;
            
         elsif
           TastenbelegungVariablen.Einheitenbelegung (EinheitenbelegungSchleifenwert) = TasteExtern
         then
            TastenbelegungVariablen.Einheitenbelegung (EinheitenbelegungSchleifenwert) := Sf.Window.Keyboard.sfKeyUnknown;
            
         else
            null;
         end if;
         
      end loop EinheitenbelegungSchleife;
      
   end Einheitenbelegung;

end SteuerungsauswahlLogik;

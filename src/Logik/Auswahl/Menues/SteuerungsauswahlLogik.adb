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
         NachGrafiktask.AktuelleAuswahl.AuswahlEins := AktuelleAuswahl;
         
         case
           TasteneingabeLogik.VereinfachteEingabe
         is
            when TastenbelegungDatentypen.Auswählen_Enum =>
               if
                 AktuelleAuswahl < SystemKonstanten.LeerAuswahl
               then
                  WelcheSteuerung := NummerZuKategorie (AktuelleAuswahl);
                  
               elsif
                 AktuelleAuswahl in SystemKonstanten.AllgemeineSteuerung .. SystemKonstanten.SonstigesSteuerung - 1
               then
                  TasteBelegen (AuswahlExtern         => AktuelleAuswahl,
                                WelcheSteuerungExtern => WelcheSteuerung);
                  
               elsif
                 AktuelleAuswahl >= SystemKonstanten.SonstigesSteuerung
               then
                  return MenuerueckgabenLogik.SteuerungMenü (AnfangExtern          => SystemKonstanten.SonstigesSteuerung,
                                                              EndeExtern            => InteraktionAuswahl.PositionenSteuerung'Last,
                                                              AktuelleAuswahlExtern => AktuelleAuswahl);
                  
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
      WelcheSteuerungExtern : in Kategorie_Enum)
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
         when Kategorie_Eins_Enum =>
            AllgemeineBelegung (AuswahlExtern => AuswahlExtern - SystemKonstanten.AllgemeineSteuerungEnumausgleich,
                                TasteExtern   => NeueTaste);
            
         when Kategorie_Zwei_Enum =>
            Einheitenbelegung (AuswahlExtern => AuswahlExtern - SystemKonstanten.EinheitensteuerungEnumausgleich,
                               TasteExtern   => NeueTaste);
            
         when Kategorie_Drei_Enum =>
            Stadtbelegung (AuswahlExtern => AuswahlExtern - SystemKonstanten.StadtsteuerungEnumausgleich,
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
   
   
   
   procedure Stadtbelegung
     (AuswahlExtern : in Positive;
      TasteExtern : in Sf.Window.Keyboard.sfKeyCode)
   is begin
      
      StadtbelegungSchleife:
      for StadtbelegungSchleifenwert in TastenbelegungVariablen.StadtbelegungArray'Range loop
         
         if
           StadtbelegungSchleifenwert = BefehleDatentypen.Stadtbefehle_Enum'Val (AuswahlExtern)
         then
            TastenbelegungVariablen.Stadtbelegung (StadtbelegungSchleifenwert) := TasteExtern;
            
         elsif
           TastenbelegungVariablen.Stadtbelegung (StadtbelegungSchleifenwert) = TasteExtern
         then
            TastenbelegungVariablen.Stadtbelegung (StadtbelegungSchleifenwert) := Sf.Window.Keyboard.sfKeyUnknown;
            
         else
            null;
         end if;
         
      end loop StadtbelegungSchleife;
      
   end Stadtbelegung;

end SteuerungsauswahlLogik;

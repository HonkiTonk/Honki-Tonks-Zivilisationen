with TastenbelegungDatentypen;
with BefehleDatentypen;
with InteraktionAuswahl;
with MenueKonstanten;
with GrafikDatentypen;
with TextnummernKonstanten;
with AuswahlKonstanten;

with LeseTastenbelegungDatenbank;
with SchreibeTastenbelegungDatenbank;

with NachGrafiktask;
with TasteneingabeLogik;
with MenuerueckgabenLogik;
with MausauswahlLogik;
with OftVerwendetSound;

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
                 AktuelleAuswahl < AuswahlKonstanten.LeerAuswahl
               then
                  OftVerwendetSound.Klick;
                  WelcheSteuerung := NummerZuKategorie (AktuelleAuswahl);
                  
               elsif
                 AktuelleAuswahl in MenueKonstanten.AllgemeineSteuerung .. MenueKonstanten.SonstigesSteuerung - 1
               then
                  OftVerwendetSound.Klick;
                  TasteBelegen (AuswahlExtern         => AktuelleAuswahl,
                                WelcheSteuerungExtern => WelcheSteuerung);
                  
               elsif
                 AktuelleAuswahl >= MenueKonstanten.SonstigesSteuerung
               then
                  OftVerwendetSound.Klick;
                  return MenuerueckgabenLogik.SteuerungMenü (AnfangExtern          => MenueKonstanten.SonstigesSteuerung,
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
      WelcheSteuerungExtern : in Tastenbelegungskategorie_Enum)
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
         when Allgemeine_Belegung_Enum =>
            AllgemeineBelegung (AuswahlExtern => AuswahlExtern - MenueKonstanten.AllgemeineSteuerungEnumausgleich,
                                TasteExtern   => NeueTaste);
            
         when Einheitenbelegung_Enum =>
            Einheitenbelegung (AuswahlExtern => AuswahlExtern - MenueKonstanten.EinheitensteuerungEnumausgleich,
                               TasteExtern   => NeueTaste);
            
         when Stadtbelegung_Enum =>
            Stadtbelegung (AuswahlExtern => AuswahlExtern - MenueKonstanten.StadtsteuerungEnumausgleich,
                           TasteExtern   => NeueTaste);
      end case;
      
   end TasteBelegen;
   
   
   
   procedure AllgemeineBelegung
     (AuswahlExtern : in Positive;
      TasteExtern : in Sf.Window.Keyboard.sfKeyCode)
   is
      use type TastenbelegungDatentypen.Allgemeine_Belegung_Enum;
   begin
      
      AllgemeineBelegungSchleife:
      for AllgemeineBelegungSchleifenwert in TastenbelegungDatentypen.Allgemeine_Belegung_Vorhanden_Enum'Range loop
         
         if
           AllgemeineBelegungSchleifenwert = TastenbelegungDatentypen.Allgemeine_Belegung_Enum'Val (AuswahlExtern)
         then
            SchreibeTastenbelegungDatenbank.AllgemeineBelegung (BefehlExtern => AllgemeineBelegungSchleifenwert,
                                                                TasteExtern  => TasteExtern);
            
         elsif
           LeseTastenbelegungDatenbank.AllgemeineBelegung (BefehlExtern => AllgemeineBelegungSchleifenwert) = TasteExtern
         then
            SchreibeTastenbelegungDatenbank.AllgemeineBelegung (BefehlExtern => AllgemeineBelegungSchleifenwert,
                                                                TasteExtern  => Sf.Window.Keyboard.sfKeyUnknown);
            
         else
            null;
         end if;
         
      end loop AllgemeineBelegungSchleife;
      
   end AllgemeineBelegung;
   
   
   
   procedure Einheitenbelegung
     (AuswahlExtern : in Positive;
      TasteExtern : in Sf.Window.Keyboard.sfKeyCode)
   is
      use type BefehleDatentypen.Einheitenbelegung_Enum;
   begin
      
      EinheitenbelegungSchleife:
      for EinheitenbelegungSchleifenwert in BefehleDatentypen.Einheitenbelegung_Vorhanden_Enum'Range loop
         
         if
           EinheitenbelegungSchleifenwert = BefehleDatentypen.Einheitenbelegung_Enum'Val (AuswahlExtern)
         then
            SchreibeTastenbelegungDatenbank.Einheitenbelegung (BefehlExtern => EinheitenbelegungSchleifenwert,
                                                               TasteExtern  => TasteExtern);
            
         elsif
           LeseTastenbelegungDatenbank.Einheitenbelegung (BefehlExtern => EinheitenbelegungSchleifenwert) = TasteExtern
         then
            SchreibeTastenbelegungDatenbank.Einheitenbelegung (BefehlExtern => EinheitenbelegungSchleifenwert,
                                                               TasteExtern  => Sf.Window.Keyboard.sfKeyUnknown);
            
         else
            null;
         end if;
         
      end loop EinheitenbelegungSchleife;
      
   end Einheitenbelegung;
   
   
   
   procedure Stadtbelegung
     (AuswahlExtern : in Positive;
      TasteExtern : in Sf.Window.Keyboard.sfKeyCode)
   is
      use type BefehleDatentypen.Stadtbefehle_Enum;
   begin
      
      StadtbelegungSchleife:
      for StadtbelegungSchleifenwert in BefehleDatentypen.Stadtbefehle_Auswählen_Enum'Range loop
         
         if
           StadtbelegungSchleifenwert = BefehleDatentypen.Stadtbefehle_Enum'Val (AuswahlExtern)
         then
            SchreibeTastenbelegungDatenbank.Stadtbelegung (BefehlExtern => StadtbelegungSchleifenwert,
                                                           TasteExtern  => TasteExtern);
            
         elsif
           LeseTastenbelegungDatenbank.Stadtbelegung (BefehlExtern => StadtbelegungSchleifenwert) = TasteExtern
         then
            SchreibeTastenbelegungDatenbank.Stadtbelegung (BefehlExtern => StadtbelegungSchleifenwert,
                                                           TasteExtern  => Sf.Window.Keyboard.sfKeyUnknown);
            
         else
            null;
         end if;
         
      end loop StadtbelegungSchleife;
      
   end Stadtbelegung;

end SteuerungsauswahlLogik;

with BefehleDatentypen;
with InteraktionAuswahl;
with MenueKonstanten;
with GrafikDatentypen;
with TextnummernKonstanten;
with AuswahlKonstanten;

with LeseTastenbelegungDatenbank;
with SchreibeTastenbelegungDatenbank;
with SchreibeGrafiktask;

with TasteneingabeLogik;
with MenuerueckgabenLogik;
with MausauswahlLogik;
with OftVerwendeterSound;
with EingabeAllgemeinLogik;

package body SteuerungsauswahlLogik is
      
   function Auswahl
     return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
            
      SchreibeGrafiktask.Zweitauswahl (AuswahlExtern => AuswahlKonstanten.LeerAuswahl);
      
      AuswahlSchleife:
      loop
         
         AktuelleAuswahl := MausauswahlLogik.Steuerung;
         AllgemeineAuswahl := TasteneingabeLogik.VereinfachteEingabe;
         
         case
           AllgemeineAuswahl
         is
            when TastenbelegungDatentypen.Abwählen_Enum =>
               return RueckgabeDatentypen.Zurück_Enum;
               
            when others =>
               null;
         end case;
         
         if
           AktuelleAuswahl.Erstauswahl /= AuswahlKonstanten.LeerAuswahl
         then
            SchreibeGrafiktask.Erstauswahl (AuswahlExtern => AktuelleAuswahl.Erstauswahl);
            
            case
              AllgemeineAuswahl
            is
               when TastenbelegungDatentypen.Auswählen_Enum =>
                  if
                    AktuelleAuswahl.Erstauswahl < AuswahlKonstanten.LeerAuswahl
                  then
                     OftVerwendeterSound.Klick;
                     WelcheSteuerung := NummerZuKategorie (AktuelleAuswahl.Erstauswahl);
                  
                  elsif
                    AktuelleAuswahl.Erstauswahl in MenueKonstanten.AllgemeineSteuerung .. MenueKonstanten.SonstigesSteuerung - 1
                  then
                     OftVerwendeterSound.Klick;
                     TasteBelegen (AuswahlExtern         => AktuelleAuswahl.Erstauswahl,
                                   WelcheSteuerungExtern => WelcheSteuerung);
                  
                  elsif
                    AktuelleAuswahl.Erstauswahl >= MenueKonstanten.SonstigesSteuerung
                  then
                     OftVerwendeterSound.Klick;
                     return MenuerueckgabenLogik.SteuerungMenü (AnfangExtern          => MenueKonstanten.SonstigesSteuerung,
                                                                 EndeExtern            => InteraktionAuswahl.PositionenSteuerung'Last,
                                                                 AktuelleAuswahlExtern => AktuelleAuswahl.Erstauswahl);
                  
                  else
                     null;
                  end if;
               
               when others =>
                  null;
            end case;
            
         elsif
           AktuelleAuswahl.Zweitauswahl /= AuswahlKonstanten.LeerAuswahl
         then
            
            case
              AllgemeineAuswahl
            is
               when TastenbelegungDatentypen.Auswählen_Enum =>
                  OftVerwendeterSound.Klick;
                  SchreibeGrafiktask.Zweitauswahl (AuswahlExtern => AktuelleAuswahl.Zweitauswahl);
                  
               when others =>
                  null;
            end case;
            
         else
            null;
         end if;
            
      end loop AuswahlSchleife;
      
   end Auswahl;
   
   
   
   procedure TasteBelegen
     (AuswahlExtern : in Positive;
      WelcheSteuerungExtern : in TastenbelegungDatentypen.Tastenbelegungskategorie_Enum)
   is begin
      
      SchreibeGrafiktask.Fragenanzeige (FrageExtern => TextnummernKonstanten.FrageNeueTaste);
      SchreibeGrafiktask.Eingabeart (EingabeartExtern => GrafikDatentypen.Zeichen_Eingabe_Enum);
      
      NeueTaste := TasteneingabeLogik.TastenbelegungAnpassen;
      
      EingabeAllgemeinLogik.LeerEingabeartFrage;
      
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
         when TastenbelegungDatentypen.Allgemeinbelegung_Enum =>
            AllgemeineBelegung (AuswahlExtern => AuswahlExtern - MenueKonstanten.AllgemeineSteuerungEnumausgleich,
                                TasteExtern   => NeueTaste);
            
         when TastenbelegungDatentypen.Einheitenbelegung_Enum =>
            Einheitenbelegung (AuswahlExtern => AuswahlExtern - MenueKonstanten.EinheitensteuerungEnumausgleich,
                               TasteExtern   => NeueTaste);
            
         when TastenbelegungDatentypen.Stadtbelegung_Enum =>
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

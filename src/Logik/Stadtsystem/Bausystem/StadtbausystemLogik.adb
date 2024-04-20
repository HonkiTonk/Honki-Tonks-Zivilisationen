with GrafikDatentypen;
with TastenbelegungDatentypen;
with TextnummernKonstanten;
with Grafiktask;
with AuswahlKonstanten;

with SchreibeStadtGebaut;
with LeseStadtGebaut;
with SchreibeGrafiktask;

with TasteneingabeLogik;
with GebaeudeanforderungenLogik;
with EinheitenanforderungenLogik;
with InteraktionAuswahl;
with MausauswahlLogik;
with OftVerwendetSound;
with JaNeinLogik;

package body StadtbausystemLogik is

   procedure Bauen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is
      use type StadtRecords.BauprojektRecord;
   begin
      
      NeuesBauprojekt := AuswahlBauprojekt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                            AktuelleBauprojektExtern => LeseStadtGebaut.Bauprojekt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern));
      
      if
        (NeuesBauprojekt.Gebäude = AuswahlKonstanten.LeerGebäudeauswahl
         and
           NeuesBauprojekt.Einheit = AuswahlKonstanten.LeerEinheitenauswahl)
        or
          NeuesBauprojekt = LeseStadtGebaut.Bauprojekt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern)
      then
         null;
            
      else
         SchreibeStadtGebaut.Bauprojekt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                         BauprojektExtern         => NeuesBauprojekt);
         SchreibeStadtGebaut.Material (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                       MaterialExtern           => StadtKonstanten.LeerMaterial,
                                       ÄndernSetzenExtern       => False);
      end if;
      
      SchreibeGrafiktask.Darstellung (DarstellungExtern => GrafikDatentypen.Stadtumgebung_Enum);
      
   end Bauen;
   
   
   
   function AuswahlBauprojekt
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      AktuelleBauprojektExtern : in StadtRecords.BauprojektRecord)
      return StadtRecords.BauprojektRecord
   is
      use type StadtDatentypen.Bauprojektart_Enum;
   begin
      
      case
        Grafiktask.WelchesBaumenü
      is
         when StadtDatentypen.Gebäudeart_Enum =>
            MöglicheGebäudeErmitteln (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
            
         when StadtDatentypen.Einheitenart_Enum =>
            MöglicheEinheitenErmitteln (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      end case;
      
      SchreibeGrafiktask.Darstellung (DarstellungExtern => GrafikDatentypen.Bauen_Enum);
      
      AuswahlSchleife:
      loop
         
         AktuelleAuswahl := MausauswahlLogik.Baumenü;
         SchreibeGrafiktask.Gebäudeauswahl (GebäudeExtern => AktuelleAuswahl.Gebäude);
         SchreibeGrafiktask.Einheitenauswahl (EinheitExtern => AktuelleAuswahl.Einheit);
         
         -- Das auch mal in die Lese/Schreibebereiche packen. äöü
         Grafiktask.Auswahl.Bauauswahl.Bauprojektart := AktuelleAuswahl.Bauprojektart;
         
         case
           TasteneingabeLogik.VereinfachteEingabe
         is               
            when TastenbelegungDatentypen.Auswählen_Enum =>
               if
                 AktuelleAuswahl.Bauprojektart /= StadtDatentypen.Leer_Bauprojektart
               then
                  Grafiktask.WelchesBaumenü := AktuelleAuswahl.Bauprojektart;
                  
                  case
                    Grafiktask.WelchesBaumenü
                  is
                     when StadtDatentypen.Gebäudeart_Enum =>
                        MöglicheGebäudeErmitteln (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
            
                     when StadtDatentypen.Einheitenart_Enum =>
                        MöglicheEinheitenErmitteln (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
                  end case;
                  
               elsif
                 AktuelleAuswahl.Gebäude = AuswahlKonstanten.LeerGebäudeauswahl
                 and
                   AktuelleAuswahl.Einheit = AuswahlKonstanten.LeerEinheitenauswahl
               then
                  null;
                  
              -- elsif
              --   AktuelleAuswahl. = Test'Last
              -- then
              --    case
              --      Grafiktask.WelchesBaumenü
              --    is
              --       when StadtDatentypen.Gebäudeart_Enum =>
              --          MöglicheGebäudeErmitteln (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
            
              --       when StadtDatentypen.Einheitenart_Enum =>
              --          MöglicheEinheitenErmitteln (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
             --     end case;
                  
               elsif
                 AktuelleBauprojektExtern.Gebäude = AuswahlKonstanten.LeerGebäudeauswahl
                 and
                   AktuelleBauprojektExtern.Einheit = AuswahlKonstanten.LeerEinheitenauswahl
               then
                  OftVerwendetSound.Klick;
                  return (AktuelleAuswahl.Gebäude, AktuelleAuswahl.Einheit);
                  
               elsif
                 ((AktuelleAuswahl.Gebäude /= AuswahlKonstanten.LeerGebäudeauswahl
                   and
                     AktuelleBauprojektExtern.Gebäude /= AktuelleAuswahl.Gebäude)
                  or
                    (AktuelleAuswahl.Einheit /= AuswahlKonstanten.LeerEinheitenauswahl
                     and
                       AktuelleBauprojektExtern.Einheit /= AktuelleAuswahl.Einheit))
                 and then
                   JaNeinLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageBauprojektWechseln) = False
               then
                  null;
                  
               else
                  OftVerwendetSound.Klick;
                  return (AktuelleAuswahl.Gebäude, AktuelleAuswahl.Einheit);
               end if;
               
            when TastenbelegungDatentypen.Abwählen_Enum =>
               return StadtKonstanten.LeerBauprojekt;
               
            when others =>
               null;
         end case;
         
      end loop AuswahlSchleife;
      
   end AuswahlBauprojekt;
   
   
   
   procedure MöglicheGebäudeErmitteln
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is begin
      
      BaubareGebäude := 0;
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtDatentypen.GebäudeIDVorhanden'Range loop
         
         case
           GebaeudeanforderungenLogik.AnforderungenErfüllt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                             IDExtern                 => GebäudeSchleifenwert)
         is
            when True =>
               InteraktionAuswahl.MöglicheGebäude (GebäudeSchleifenwert) := True;
               
               if
                 BaubareGebäude <= 15
               then
                  BaubareGebäude := BaubareGebäude + 1;
                  Test (BaubareGebäude) := Positive (GebäudeSchleifenwert);
                  
               else
                  Test (Test'Last) := -1;
               end if;
               
            when False =>
               InteraktionAuswahl.MöglicheGebäude (GebäudeSchleifenwert) := False;
         end case;
         
      end loop GebäudeSchleife;
      
   end MöglicheGebäudeErmitteln;
   
   
   
   procedure MöglicheEinheitenErmitteln
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is begin
      
      BaubareEinheiten := 0;
      
      EinheitenSchleife:
      for EinheitSchleifenwert in EinheitenDatentypen.EinheitenIDVorhanden'Range loop
         
         case
           EinheitenanforderungenLogik.AnforderungenErfüllt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                              IDExtern                 => EinheitSchleifenwert)
         is
            when True =>
               InteraktionAuswahl.MöglicheEinheiten (EinheitSchleifenwert) := True;
               
               if
                 BaubareEinheiten <= 15
               then
                  BaubareEinheiten := BaubareEinheiten + 1;
                  Test (BaubareEinheiten) := Positive (EinheitSchleifenwert);
                  
               else
                  Test (Test'Last) := -1;
               end if;
               
            when False =>
               InteraktionAuswahl.MöglicheEinheiten (EinheitSchleifenwert) := False;
         end case;
         
      end loop EinheitenSchleife;
      
   end MöglicheEinheitenErmitteln;

end StadtbausystemLogik;

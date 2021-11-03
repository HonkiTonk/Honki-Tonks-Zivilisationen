pragma SPARK_Mode (On);

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with GlobaleTexte;
with KartenKonstanten;
with EinheitenKonstanten;

with LeseEinheitenGebaut;

with Karte;
with EinheitSuchen;
with KartePositionPruefen;
with Eingabe;
with BewegungPassierbarkeitPruefen;
with BewegungBerechnen;
with DiplomatischerZustand;
with BewegungLadenEntladen;
with KampfsystemEinheiten;
with StadtSuchen;
with EinheitenModifizieren;
with StadtBauen;
with Aufgaben;
with Anzeige;
with KampfsystemStadt;
with EinheitenTransporter;

package body BewegungEinheiten is

   procedure BewegungEinheitenRichtung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      Karte.AnzeigeKarte (RasseExtern => EinheitRasseNummerExtern.Rasse);

      BewegenSchleife:
      loop
         
         Befehl := Eingabe.Tastenwert;
         
         case
           Befehl
         is
            when SystemDatentypen.Oben =>
               Änderung := (0, -1, 0);
            
            when SystemDatentypen.Links =>
               Änderung := (0, 0, -1);
            
            when SystemDatentypen.Unten =>
               Änderung := (0, 1, 0);
            
            when SystemDatentypen.Rechts  =>
               Änderung := (0, 0, 1);
            
            when SystemDatentypen.Links_Oben =>
               Änderung := (0, -1, -1);
            
            when SystemDatentypen.Rechts_Oben =>
               Änderung := (0, -1, 1);
            
            when SystemDatentypen.Links_Unten =>
               Änderung := (0, 1, -1);

            when SystemDatentypen.Rechts_Unten =>
               Änderung := (0, 1, 1);
            
            when SystemDatentypen.Ebene_Hoch =>
               Änderung := (1, 0, 0);
            
            when SystemDatentypen.Ebene_Runter =>
               Änderung := (-1, 0, 0);
               
            when SystemDatentypen.Heimatstadt_Ändern =>
               EinheitenModifizieren.HeimatstadtÄndern (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
               Änderung := KeineÄnderung;
               
            when SystemDatentypen.Tastenbelegung_Verbesserung_Befehle_Enum'Range | SystemDatentypen.Tastenbelegung_Allgemeine_Befehle_Enum'Range =>
               AufgabeDurchführen := Aufgaben.VerbesserungAnlegen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                    BefehlExtern             => Befehl);
               
               case
                 AufgabeDurchführen
               is
                  when True =>
                     return;
               
                  when False =>
                     Änderung := KeineÄnderung;
                     Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
                                                           TextZeileExtern => 2);
               end case;
               
            when SystemDatentypen.Bauen =>
               NullWert := StadtBauen.StadtBauen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
               Änderung := KeineÄnderung;
            
            when others =>
               return;
         end case;
         
         if
           Änderung = KeineÄnderung
         then
            AktuellerStatus := NochBewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         else
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                        ÄnderungExtern    => Änderung);
         
            case
              KartenWert.XAchse
            is
               when KartenKonstanten.LeerXAchse =>
                  AktuellerStatus := Bewegbar;
               
               when others =>
                  AktuellerStatus := BewegungPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                      NeuePositionExtern       => KartenWert);
            end case;
         end if;
         
         case
           AktuellerStatus
         is
            when Bewegbar =>
               null;
               
            when Zurück =>
               return;
         end case;

         Karte.AnzeigeKarte (RasseExtern => EinheitRasseNummerExtern.Rasse);
         
      end loop BewegenSchleife;
      
   end BewegungEinheitenRichtung;
   
   
   
   function BewegungPrüfen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      NeuePositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return Bewegung_Noch_Möglich_Enum
   is begin
      
      FeldPassierbar := BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                   NeuePositionExtern       => NeuePositionExtern);
      
      EinheitAufFeld := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => NeuePositionExtern);
      StadtAufFeld := StadtSuchen.KoordinatenStadtOhneSpezielleRasseSuchen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                                            KoordinatenExtern => NeuePositionExtern);
      BewegungDurchführen := False;
      
      if
        FeldPassierbar = False
        and
          EinheitAufFeld.Platznummer = EinheitenKonstanten.LeerNummer
      then
         return Bewegbar;
         
      elsif
        EinheitAufFeld.Rasse = EinheitRasseNummerExtern.Rasse
        and then
          EinheitenTransporter.KannTransportiertWerden (LadungExtern      => EinheitRasseNummerExtern,
                                                        TransporterExtern => EinheitAufFeld)
        = False
      then
         return Bewegbar;
         
      elsif
        EinheitAufFeld.Rasse = EinheitRasseNummerExtern.Rasse
        and then
          EinheitenTransporter.KannTransportiertWerden (LadungExtern      => EinheitRasseNummerExtern,
                                                        TransporterExtern => EinheitAufFeld)
        = True
      then
         EigeneEinheitAufFeld (BewegendeEinheitExtern     => EinheitRasseNummerExtern,
                               FeldBelegendeEinheitExtern => EinheitAufFeld);
         
      elsif
        EinheitAufFeld.Rasse /= EinheitRasseNummerExtern.Rasse
        and
          EinheitAufFeld.Rasse /= EinheitenKonstanten.LeerRasse
      then
         if
           (FremderAufFeld (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                            FremdeEinheitExtern      => EinheitAufFeld)
            = True)
           and
             FeldPassierbar
         then
            BewegungDurchführen := True;
            
         else
            null;
         end if;
         
      elsif
        StadtAufFeld.Platznummer /= EinheitenKonstanten.LeerNummer
        and
          FeldPassierbar
      then
         case
           FremdeStadtAufFeld (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                               FremdeStadtExtern        => StadtAufFeld)
         is
            when False =>
               null;
               
            when True =>
               BewegungDurchführen := True;
         end case;
         
      else
         BewegungDurchführen := True;
      end if;
      
      case
        BewegungDurchführen
      is
         when True =>
            BewegungBerechnen.BewegungEinheitenBerechnung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                           NeuePositionExtern       => NeuePositionExtern);
            
         when False =>
            null;
      end case;
      
      return NochBewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
   end BewegungPrüfen;
   
   
   
   function NochBewegungspunkte
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Bewegung_Noch_Möglich_Enum
   is begin
      
      if
        LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerEinheit.Bewegungspunkte
        or
          LeseEinheitenGebaut.Lebenspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerEinheit.Lebenspunkte
      then
         return Zurück;
            
      else
         return Bewegbar;
      end if;
      
   end NochBewegungspunkte;
   
   
   
   function FremderAufFeld
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      FremdeEinheitExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
   is begin
            
      case
        DiplomatischerZustand.GegnerAngreifen (EigeneRasseExtern      => EinheitRasseNummerExtern.Rasse,
                                               GegnerischeRasseExtern => FremdeEinheitExtern.Rasse)
      is
         when False =>
            return False;
            
         when True =>
            null;
      end case;
      
      if
        KampfsystemEinheiten.KampfsystemNahkampf (AngreiferExtern    => EinheitRasseNummerExtern,
                                                  VerteidigerExtern => FremdeEinheitExtern)
        = True
      then
         case
           StadtAufFeld.Platznummer
         is
            when EinheitenKonstanten.LeerNummer =>
               return True;
                     
            when others =>
               null;
         end case;
               
      else
         null;
      end if;
      
      return False;
      
   end FremderAufFeld;
   
   
   
   function FremdeStadtAufFeld
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      FremdeStadtExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      case
        DiplomatischerZustand.GegnerAngreifen (EigeneRasseExtern      => EinheitRasseNummerExtern.Rasse,
                                               GegnerischeRasseExtern => FremdeStadtExtern.Rasse)
      is
         when True =>
            return KampfsystemStadt.KampfsystemStadt (AngreifendeEinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                      VerteidigendeStadtRasseNummerExtern => FremdeStadtExtern);
            
         when False =>
            return False;
      end case;
      
   end FremdeStadtAufFeld;
   
   
   
   -- Hier vielleicht später mehr einbauen? Beispielsweise Plätzetauschen?
   procedure EigeneEinheitAufFeld
     (BewegendeEinheitExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      FeldBelegendeEinheitExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      BewegungLadenEntladen.TransporterBeladen (TransporterExtern => FeldBelegendeEinheitExtern,
                                                LadungExtern      => BewegendeEinheitExtern.Platznummer);
      
   end EigeneEinheitAufFeld;

end BewegungEinheiten;

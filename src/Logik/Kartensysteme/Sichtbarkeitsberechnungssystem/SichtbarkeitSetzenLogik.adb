with StadtKonstanten;

with LeseWeltkarte;
with SchreibeWeltkarte;

with EinheitSuchenLogik;
with KennenlernenLogik;
with Fehlermeldungssystem;

package body SichtbarkeitSetzenLogik is

   -- Sollte man von Oben auch den Anfang der Unterflächenlandfelder sehen oder die so schwarz lassen? äöü
   -- Beziehungsweise auch umgekehrt? äöü
   -- Sollte man von der Unterfläche auch den Himmel sehen können? äöü
   procedure EbenenBerechnungen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      Basisgrund := LeseWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.OberflächeKonstante =>
            if
              Basisgrund in KartengrundDatentypen.Basisgrund_Oberfläche_Wasser_Enum'Range
            then
               EAchseAnfang := KartenKonstanten.UnterflächeKonstante;
               
            else
               EAchseAnfang := KartenKonstanten.OberflächeKonstante;
            end if;
            
            EAchseEnde := KartenKonstanten.HimmelKonstante;
            
         when KartenKonstanten.HimmelKonstante =>
            EAchseAnfang := KartenKonstanten.OberflächeKonstante;
            EAchseEnde := KartenKonstanten.WeltraumKonstante;
            
         when KartenKonstanten.WeltraumKonstante =>
            EAchseAnfang := KartenKonstanten.HimmelKonstante;
            EAchseEnde := KartenKonstanten.WeltraumKonstante;
            
         when KartenKonstanten.UnterflächeKonstante =>
            EAchseAnfang := KartenKonstanten.UnterflächeKonstante;
            
            if
              Basisgrund in KartengrundDatentypen.Basisgrund_Unterfläche_Wasser_Enum'Range
            then
               EAchseEnde := KartenKonstanten.OberflächeKonstante;
               
            else
               EAchseEnde := KartenKonstanten.UnterflächeKonstante;
            end if;
            
         when KartenKonstanten.PlaneteninneresKonstante =>
            EAchseAnfang := KartenKonstanten.PlaneteninneresKonstante;
            EAchseEnde := KartenKonstanten.PlaneteninneresKonstante;
            
         when others =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "SichtbarkeitSetzenLogik.EbenenBerechnungen: Ungültige Ebene: " & KoordinatenExtern.EAchse'Wide_Wide_Image);
      end case;
      
      EAchse:
      for EAchseSchleifenwert in EAchseAnfang .. EAchseEnde loop
         
         SichtbarkeitSetzen (RasseExtern       => RasseExtern,
                             KoordinatenExtern => (EAchseSchleifenwert, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse));
         
      end loop EAchse;
      
   end EbenenBerechnungen;
   
   
   
   -- Prüft ob auf einem neu aufgedecktem Feld sich eine fremde Stadt/Einheit befindet und stellt entsprechend Kontakt her.
   -- Anders als die Berechnung in BewegungsberechnungLogik, wo geprüft wird ob die Einheit jetzt auf einem Feld steht welches von einer fremden Rasse bereits aufgedeckt wurde.
   procedure SichtbarkeitSetzen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is
      use type RassenDatentypen.Rassen_Enum;
   begin
            
      case
        LeseWeltkarte.Sichtbar (KoordinatenExtern => KoordinatenExtern,
                                RasseExtern       => RasseExtern)
      is
         when True =>
            return;
            
         when False =>
            SchreibeWeltkarte.Sichtbar (KoordinatenExtern => KoordinatenExtern,
                                        RasseExtern       => RasseExtern,
                                        SichtbarExtern    => True);
      end case;
      
      FremdeEinheit := EinheitSuchenLogik.KoordinatenEinheitOhneSpezielleRasseSuchen (RasseExtern       => RasseExtern,
                                                                                      KoordinatenExtern => KoordinatenExtern,
                                                                                      LogikGrafikExtern => True);
      
      case
        FremdeEinheit.Rasse
      is
         when StadtKonstanten.LeerRasse =>
            null;
            
         when others =>
            KennenlernenLogik.Erstkontakt (EigeneRasseExtern => RasseExtern,
                                           FremdeRasseExtern => FremdeEinheit.Rasse);
            return;
      end case;
      
      FremdeStadt := LeseWeltkarte.StadtbelegungGrund (KoordinatenExtern => KoordinatenExtern);
      
      if
        FremdeStadt.Rasse = RassenDatentypen.Keine_Rasse_Enum
        or
          FremdeStadt.Rasse = RasseExtern
      then
         null;
            
      else
         KennenlernenLogik.Erstkontakt (EigeneRasseExtern => RasseExtern,
                                        FremdeRasseExtern => FremdeStadt.Rasse);
      end if;
      
   end SichtbarkeitSetzen;

end SichtbarkeitSetzenLogik;

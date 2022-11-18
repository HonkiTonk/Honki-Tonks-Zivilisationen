with KartengrundDatentypen;
with KartenKonstanten;
with StadtKonstanten;

with LeseWeltkarte;
with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;
with LeseVerbesserungenDatenbank;
with LeseStadtGebaut;

with StadtSuchenLogik;
with KartenkoordinatenberechnungssystemLogik;
with KartenAllgemeinesLogik;
with Fehlermeldungssystem;

package body PassierbarkeitspruefungLogik is
   
   function PassierbarkeitPrüfenNummer
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      IDEinheit := LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      case
        IDEinheit
      is
         when EinheitenDatentypen.EinheitenIDMitNullWert'First =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenNummer: Einheit ohne ID.");
            return False;
            
         when others =>
            return PassierbarkeitPrüfenID (RasseExtern                => EinheitRasseNummerExtern.Rasse,
                                            IDExtern                   => IDEinheit,
                                            NeueKoordinatenExtern      => NeueKoordinatenExtern,
                                            StadtBerücksichtigenExtern => True);
      end case;
      
   end PassierbarkeitPrüfenNummer;
   
   
   
   -- Funktioniert noch nicht korrekt wenn sich darunter/oben drüber eine Stadt befindet. äöü
   -- So lassen oder später noch einmal anpassen? äöü
   function PassierbarkeitPrüfenID
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenID;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      StadtBerücksichtigenExtern : in Boolean)
      return Boolean
   is begin
            
      PassierbarkeitSchleife:
      for PassierbarkeitSchleifenwert in EinheitenDatentypen.Passierbarkeit_Enum'Range loop
         
         case
           LeseEinheitenDatenbank.Passierbarkeit (RasseExtern          => RasseExtern,
                                                  IDExtern             => IDExtern,
                                                  WelcheUmgebungExtern => PassierbarkeitSchleifenwert)
         is
            when False =>
               Passierbar := False;
               
            when True =>
               Passierbar := IstPassierbar (RasseExtern                => RasseExtern,
                                            UmgebungExtern             => PassierbarkeitSchleifenwert,
                                            NeueKoordinatenExtern      => NeueKoordinatenExtern,
                                            StadtBerücksichtigenExtern => StadtBerücksichtigenExtern);
         end case;
         
         case
           Passierbar
         is
            when True =>
               return True;
               
            when False =>
               null;
         end case;
         
      end loop PassierbarkeitSchleife;
      
      return False;
      
   end PassierbarkeitPrüfenID;
   
   
   
   -- Eventuell mit IstNichtPassierbar zusammenführen oder anders aufteilen. äöü
   function IstPassierbar
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      UmgebungExtern : in EinheitenDatentypen.Passierbarkeit_Enum;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      StadtBerücksichtigenExtern : in Boolean)
      return Boolean
   is begin
      
      case
        KartenAllgemeinesLogik.PassierbarGrund (KoordinatenExtern    => NeueKoordinatenExtern,
                                                PassierbarkeitExtern => UmgebungExtern)
      is
         when True =>
            return True;
            
         when False =>
            null;
      end case;
      
      case
        StadtBerücksichtigenExtern
      is
         when True =>
            StadtVorhanden := StadtSuchenLogik.KoordinatenStadtMitRasseSuchen (RasseExtern       => RasseExtern,
                                                                               KoordinatenExtern => NeueKoordinatenExtern);
            
         when False =>
            StadtVorhanden := StadtKonstanten.LeerNummer;
      end case;
           
      case
        StadtVorhanden
      is
         when StadtKonstanten.LeerNummer =>
            return IstNichtPassierbar (RasseExtern           => RasseExtern,
                                       UmgebungExtern        => UmgebungExtern,
                                       NeueKoordinatenExtern => NeueKoordinatenExtern);
            
         when others =>
            return True;
      end case;
      
   end IstPassierbar;
   
   
   
   function IstNichtPassierbar
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      UmgebungExtern : in EinheitenDatentypen.Passierbarkeit_Enum;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is
      use type RassenDatentypen.Rassen_Enum;
   begin
            
      WegVorhanden := LeseWeltkarte.Weg (KoordinatenExtern => NeueKoordinatenExtern);
      
      case
        WegVorhanden
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            if
              RasseExtern = RassenDatentypen.Ekropa_Enum
            then
               null;
               
            else
               return False;
            end if;
            
         when others =>
            return LeseVerbesserungenDatenbank.PassierbarkeitWeg (WegExtern            => WegVorhanden,
                                                                  WelcheUmgebungExtern => UmgebungExtern);
      end case;
      
      -- Notwendig da sonst auch Schiffe über Schienen verschoben werden können. äöü
      -- Wobei das vielleicht eine interessante Idee wäre. äöü
      case
        LeseWeltkarte.Basisgrund (KoordinatenExtern => NeueKoordinatenExtern)
      is
         when KartengrundDatentypen.Wasser_Enum | KartengrundDatentypen.Küstengewässer_Enum =>
            null;
            
         when others =>
            return False;
      end case;
      
      -- Diese Prüfung für die Ekropa später noch einmal überarbeiten und auch die vorhandene Forschung berücksichtigen. äöü
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
            
            Ekropaumgebung := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => NeueKoordinatenExtern,
                                                                                                          ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                          LogikGrafikExtern => True);
            
            case
              Ekropaumgebung.XAchse
            is
               when KartenKonstanten.LeerXAchse =>
                  null;
                  
               when others =>
                  if
                    LeseWeltkarte.Weg (KoordinatenExtern => Ekropaumgebung) in KartenverbesserungDatentypen.Karten_Schiene_Enum'Range
                  then
                     return True;
                     
                  else
                     null;
                  end if;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      return False;
      
   end IstNichtPassierbar;
   
   
   
   -- In eine eigene Datei verschieben? äöü
   function RichtigeUmgebungVorhanden
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      EinheitenIDExtern : in EinheitenDatentypen.EinheitenID)
      return Boolean
   is begin
            
      StadtKoordinaten := LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern);
      Stadtumgebung := LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      YAchseSchleife:
      for YAchseSchleifenwert in -Stadtumgebung .. Stadtumgebung loop
         XAchseSchleife:
         for XAchseSchleifenwert in -Stadtumgebung .. Stadtumgebung loop
            
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => StadtKoordinaten,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                      LogikGrafikExtern => True);
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              False = LeseWeltkarte.BestimmteStadtBelegtGrund (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                               KoordinatenExtern      => KartenWert)
            then
               null;
            
            elsif
              False = PassierbarkeitPrüfenID (RasseExtern                => StadtRasseNummerExtern.Rasse,
                                               IDExtern                   => EinheitenIDExtern,
                                               NeueKoordinatenExtern      => KartenWert,
                                               StadtBerücksichtigenExtern => False)
            then
               null;
            
            else
               return True;
            end if;
               
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      return False;
      
   end RichtigeUmgebungVorhanden;

end PassierbarkeitspruefungLogik;

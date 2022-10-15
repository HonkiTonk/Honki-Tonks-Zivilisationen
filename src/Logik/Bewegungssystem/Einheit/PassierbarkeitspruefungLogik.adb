pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with KartenverbesserungDatentypen; use KartenverbesserungDatentypen;
with StadtDatentypen; use StadtDatentypen;
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
with Fehler;

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
            Fehler.LogikFehler (FehlermeldungExtern => "BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenNummer: Einheit ohne ID.");
            return False;
            
         when others =>
            return PassierbarkeitPrüfenID (RasseExtern           => EinheitRasseNummerExtern.Rasse,
                                            IDExtern              => IDEinheit,
                                            NeueKoordinatenExtern => NeueKoordinatenExtern);
      end case;
      
   end PassierbarkeitPrüfenNummer;
   
   
   
   function PassierbarkeitPrüfenID
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenID;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
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
               Passierbar := IstNichtPassierbar (RasseExtern           => RasseExtern,
                                                 UmgebungExtern        => PassierbarkeitSchleifenwert,
                                                 NeueKoordinatenExtern => NeueKoordinatenExtern);
               
            when True =>
               Passierbar := IstPassierbar (RasseExtern           => RasseExtern,
                                            UmgebungExtern        => PassierbarkeitSchleifenwert,
                                            NeueKoordinatenExtern => NeueKoordinatenExtern);
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
   
   
   
   -- Haut so mit der Prüfung gar nicht hin. äöü
   -- Ich prüfe ja nicht ob die Einheit diesen Weg betreten kann, sondern ob der aktuelle Schleifenwert das kann. äöü
   function IstNichtPassierbar
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      UmgebungExtern : in EinheitenDatentypen.Passierbarkeit_Enum;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      case
        StadtSuchenLogik.KoordinatenStadtMitRasseSuchen (RasseExtern       => RasseExtern,
                                                         KoordinatenExtern => NeueKoordinatenExtern)
      is
         when StadtKonstanten.LeerNummer =>
            WegVorhanden := LeseWeltkarte.Weg (KoordinatenExtern => NeueKoordinatenExtern);

         when others =>
            return True;
      end case;
      
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
      
      -- Diese Prüfung für die Ekropa später noch einmal überarbeiten und auch die vorhandene Forschung berücksichtigen. äöü
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
            
            Ekropaumgebung := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => NeueKoordinatenExtern,
                                                                                                          ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert),
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
   
   
   
   function IstPassierbar
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      UmgebungExtern : in EinheitenDatentypen.Passierbarkeit_Enum;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      case
        KartenAllgemeinesLogik.PassierbarGrund (KoordinatenExtern    => NeueKoordinatenExtern,
                                                PassierbarkeitExtern => UmgebungExtern)
      is
         when True =>
            return True;
            
         when False =>
            return IstNichtPassierbar (RasseExtern           => RasseExtern,
                                       UmgebungExtern        => UmgebungExtern,
                                       NeueKoordinatenExtern => NeueKoordinatenExtern);
      end case;
      
   end IstPassierbar;
   
   
   
   -- In eine eigene Datei verschieben? äöü
   function RichtigeUmgebungVorhanden
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      EinheitenIDExtern : in EinheitenDatentypen.EinheitenID)
      return Boolean
   is begin
            
      StadtKoordinaten := LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern);
      Stadtumgebung := LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      YAchseEinheitenSchleife:
      for YAchseEinheitenSchleifenwert in -Stadtumgebung .. Stadtumgebung loop
         XAchseEinheitenSchleife:
         for XAchseEinheitenSchleifenwert in -Stadtumgebung .. Stadtumgebung loop
                        
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => StadtKoordinaten,
                                                                                                      ÄnderungExtern    => (0, YAchseEinheitenSchleifenwert, XAchseEinheitenSchleifenwert),
                                                                                                      LogikGrafikExtern => True);
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
               -- Das hier muss noch einmal überarbeitet werden, ist aktuell nur deswegen da weil die Stadt nicht ausgeschlossen werden kann. äöü
               -- Die Stadt sollte aber ausgeschlossen werden, nicht aber das Feld auf dem sich die Stadt befindet. äöü
            elsif
              YAchseEinheitenSchleifenwert = 0
              and
                XAchseEinheitenSchleifenwert = 0
            then
               null;
               
            elsif
              False = LeseWeltkarte.BestimmteStadtBelegtGrund (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                               KoordinatenExtern      => KartenWert)
            then
               null;
            
            elsif
              False = PassierbarkeitPrüfenID (RasseExtern           => StadtRasseNummerExtern.Rasse,
                                               IDExtern              => EinheitenIDExtern,
                                               NeueKoordinatenExtern => KartenWert)
            then
               null;
            
            else
               return True;
            end if;
               
         end loop XAchseEinheitenSchleife;
      end loop YAchseEinheitenSchleife;
      
      return False;
      
   end RichtigeUmgebungVorhanden;

end PassierbarkeitspruefungLogik;

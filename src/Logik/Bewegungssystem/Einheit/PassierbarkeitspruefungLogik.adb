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
            return False;
            
         when others =>
            return LeseVerbesserungenDatenbank.PassierbarkeitWeg (WegExtern            => WegVorhanden,
                                                                  WelcheUmgebungExtern => UmgebungExtern);
      end case;
      
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
   
   
   
   -- Überarbeiten und in eine eigene Datei verschieben. äöü
   function RichtigeUmgebungVorhanden
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      EinheitenIDExtern : in EinheitenDatentypen.EinheitenID)
      return Boolean
   is begin
      
      StadtKoordinaten := LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      -- Bei Einheiten nur um das direkte StadtumfeldUmfeld loopen. Das ist doch Blödsinn, die Einheiten werden ja auf einem beliebigen Feld innerhalb des Stadtbereiches platziert. äöü
      -- Oder reicht das weil es ja hauptsächlich dazu da ist um z.B. Panzer im Himmel zu verhindern? äöü
      YAchseEinheitenSchleife:
      for YAchseEinheitenSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseEinheitenSchleife:
         for XAchseEinheitenSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
               
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => StadtKoordinaten,
                                                                                                      ÄnderungExtern    => (0, YAchseEinheitenSchleifenwert, XAchseEinheitenSchleifenwert),
                                                                                                      LogikGrafikExtern => True);
               
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              YAchseEinheitenSchleifenwert = 0
              and
                XAchseEinheitenSchleifenwert = 0
            then
               null;
                  
            elsif
              False = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenID (RasseExtern           => StadtRasseNummerExtern.Rasse,
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

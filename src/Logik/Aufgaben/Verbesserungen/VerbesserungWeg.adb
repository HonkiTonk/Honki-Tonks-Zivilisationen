pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenKonstanten;
with AufgabenDatentypen;

with SchreibeEinheitenGebaut;
with SchreibeKarten;
with LeseKarten;
with LeseEinheitenGebaut;

with Kartenkoordinatenberechnungssystem;
with AufgabenAllgemein;

package body VerbesserungWeg is
   
   -- Hier prüfen welcher Weg
   function VerbesserungWeg
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Vorhanden_Enum;
      AnlegenTestenExtern : in Boolean)
      return Boolean
   is begin
      
      if
        LeseKarten.Weg (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      in
        KartenVerbesserungDatentypen.Karten_Straße_Enum'Range
      then
         return False;

      else
         null;
      end if;

      case
        GrundExtern
      is
         when KartengrundDatentypen.Eis_Enum | KartengrundDatentypen.Flachland_Enum | KartengrundDatentypen.Tundra_Enum | KartengrundDatentypen.Wüste_Enum | KartengrundDatentypen.Hügel_Enum
            | KartengrundDatentypen.Wald_Enum =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => AufgabenDatentypen.Straße_Bauen_Enum);
            SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         ZeitExtern               => 3,
                                                         RechnenSetzenExtern      => 0);

         when KartengrundDatentypen.Gebirge_Enum | KartengrundDatentypen.Dschungel_Enum | KartengrundDatentypen.Sumpf_Enum =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => AufgabenDatentypen.Straße_Bauen_Enum);
            SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         ZeitExtern               => 6,
                                                         RechnenSetzenExtern      => 0);
               
         when others =>
            return False;
      end case;
      
      case
        AnlegenTestenExtern
      is
         when True =>
            null;
            
         when False =>
            AufgabenAllgemein.Nullsetzung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
      
      return True;
      
   end VerbesserungWeg;
   
   

   procedure WegBerechnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      YAchseSchleife:
      for YÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
            
            KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                 ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                                                 LogikGrafikExtern => True);
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              XÄnderungSchleifenwert = -1
              and
                YÄnderungSchleifenwert = 0
            then
               BerechnungLinks;
               
            elsif
              XÄnderungSchleifenwert = 1
              and
                YÄnderungSchleifenwert = 0
            then
               BerechnungRechts;
               
            elsif
              YÄnderungSchleifenwert = -1
              and
                XÄnderungSchleifenwert = 0
            then
               BerechnungOben;
               
            elsif
              YÄnderungSchleifenwert = 1
              and
                XÄnderungSchleifenwert = 0
            then
               BerechnungUnten;
               
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      WegPlatzieren (KoordinatenExtern => KoordinatenExtern);
      
   end WegBerechnen;
   
   
   
   procedure BerechnungLinks
   is begin
      
      WelcherWeg := LeseKarten.Weg (KoordinatenExtern => KartenWert);
      
      case
        WelcherWeg
      is
         when KartenVerbesserungDatentypen.Leer_Weg_Enum =>
            WegLinks := False;
            
         when others =>
            WegLinks := True;
            SchreibeKarten.Weg (KoordinatenExtern => KartenWert,
                                WegExtern         => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Val (WegeLinks (WelcherWeg)));
      end case;
      
   end BerechnungLinks;
   
   
   
   procedure BerechnungRechts
   is begin
      
      WelcherWeg := LeseKarten.Weg (KoordinatenExtern => KartenWert);
      
      case
        WelcherWeg
      is
         when KartenVerbesserungDatentypen.Leer_Weg_Enum =>
            WegRechts := False;
            
         when others =>
            WegRechts := True;
            SchreibeKarten.Weg (KoordinatenExtern => KartenWert,
                                WegExtern         => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Val (WegeRechts (WelcherWeg)));
      end case;
      
   end BerechnungRechts;
   
   
   
   procedure BerechnungOben
   is begin
      
      WelcherWeg := LeseKarten.Weg (KoordinatenExtern => KartenWert);
      
      case
        WelcherWeg
      is
         when KartenVerbesserungDatentypen.Leer_Weg_Enum =>
            WegOben := False;
            
         when others =>
            WegOben := True;
            SchreibeKarten.Weg (KoordinatenExtern => KartenWert,
                                WegExtern         => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Val (WegeOben (WelcherWeg)));
      end case;
      
   end BerechnungOben;
   
   
   
   procedure BerechnungUnten
   is begin
      
      WelcherWeg := LeseKarten.Weg (KoordinatenExtern => KartenWert);
      
      case
        WelcherWeg
      is
         when KartenVerbesserungDatentypen.Leer_Weg_Enum =>
            WegUnten := False;
            
         when others =>
            WegUnten := True;
            SchreibeKarten.Weg (KoordinatenExtern => KartenWert,
                                WegExtern         => KartenVerbesserungDatentypen.Karten_Weg_Vorhanden_Enum'Val (WegeUnten (WelcherWeg)));
      end case;
            
   end BerechnungUnten;
   
   
   
   procedure WegPlatzieren
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      SchreibeKarten.Weg (KoordinatenExtern => KoordinatenExtern,
                          WegExtern         => KartenVerbesserungDatentypen.Karten_Weg_Enum'Val (Wegwert (WegLinks, WegRechts, WegOben, WegUnten)));
      
   end WegPlatzieren;

end VerbesserungWeg;

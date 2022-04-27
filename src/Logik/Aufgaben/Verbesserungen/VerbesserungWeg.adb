pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenVerbesserungDatentypen;
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

      Wegewert := 10_000;
      
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
      
      case
        LeseKarten.Weg (KoordinatenExtern => KartenWert)
      is
         when KartenVerbesserungDatentypen.Leer_Weg_Enum =>
            Wegewert := Wegewert - 1_000;

         when KartenVerbesserungDatentypen.Straße_Senkrecht_Enum =>
            SchreibeKarten.Weg (KoordinatenExtern => KartenWert,
                                WegExtern         => KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Rechts_Enum);
                     
         when KartenVerbesserungDatentypen.Straßenkurve_Unten_Links_Enum =>
            SchreibeKarten.Weg (KoordinatenExtern => KartenWert,
                                WegExtern         => KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Unten_Enum);

         when KartenVerbesserungDatentypen.Straßenkurve_Oben_Links_Enum =>
            SchreibeKarten.Weg (KoordinatenExtern => KartenWert,
                                WegExtern         => KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Oben_Enum);

         when KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Links_Enum =>
            SchreibeKarten.Weg (KoordinatenExtern => KartenWert,
                                WegExtern         => KartenVerbesserungDatentypen.Straßenkreuzung_Vier_Enum);

         when KartenVerbesserungDatentypen.Straßenendstück_Rechts_Enum =>
            SchreibeKarten.Weg (KoordinatenExtern => KartenWert,
                                WegExtern         => KartenVerbesserungDatentypen.Straße_Waagrecht_Enum);

         when KartenVerbesserungDatentypen.Straßenendstück_Unten_Enum =>
            SchreibeKarten.Weg (KoordinatenExtern => KartenWert,
                                WegExtern         => KartenVerbesserungDatentypen.Straßenkurve_Oben_Rechts_Enum);

         when KartenVerbesserungDatentypen.Straßenendstück_Oben_Enum =>
            SchreibeKarten.Weg (KoordinatenExtern => KartenWert,
                                WegExtern         => KartenVerbesserungDatentypen.Straßenkurve_Unten_Rechts_Enum);
                     
         when KartenVerbesserungDatentypen.Straße_Einzeln_Enum =>
            SchreibeKarten.Weg (KoordinatenExtern => KartenWert,
                                WegExtern         => KartenVerbesserungDatentypen.Straßenendstück_Links_Enum);
                     
         when others =>
            null;
      end case;
      
      Wegewert := Wegewert + 1_000;
      
   end BerechnungLinks;
   
   
   
   procedure BerechnungRechts
   is begin
      
      case
        LeseKarten.Weg (KoordinatenExtern => KartenWert)
      is
         when KartenVerbesserungDatentypen.Leer_Weg_Enum =>
            Wegewert := Wegewert - 100;

         when KartenVerbesserungDatentypen.Straße_Senkrecht_Enum =>
            SchreibeKarten.Weg (KoordinatenExtern => KartenWert,
                                WegExtern         => KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Links_Enum);
                     
         when KartenVerbesserungDatentypen.Straßenkurve_Unten_Rechts_Enum =>
            SchreibeKarten.Weg (KoordinatenExtern => KartenWert,
                                WegExtern         => KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Unten_Enum);

         when KartenVerbesserungDatentypen.Straßenkurve_Oben_Rechts_Enum =>
            SchreibeKarten.Weg (KoordinatenExtern => KartenWert,
                                WegExtern         => KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Oben_Enum);

         when KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Rechts_Enum =>
            SchreibeKarten.Weg (KoordinatenExtern => KartenWert,
                                WegExtern         => KartenVerbesserungDatentypen.Straßenkreuzung_Vier_Enum);

         when KartenVerbesserungDatentypen.Straßenendstück_Links_Enum =>
            SchreibeKarten.Weg (KoordinatenExtern => KartenWert,
                                WegExtern         => KartenVerbesserungDatentypen.Straße_Waagrecht_Enum);

         when KartenVerbesserungDatentypen.Straßenendstück_Unten_Enum =>
            SchreibeKarten.Weg (KoordinatenExtern => KartenWert,
                                WegExtern         => KartenVerbesserungDatentypen.Straßenkurve_Oben_Links_Enum);

         when KartenVerbesserungDatentypen.Straßenendstück_Oben_Enum =>
            SchreibeKarten.Weg (KoordinatenExtern => KartenWert,
                                WegExtern         => KartenVerbesserungDatentypen.Straßenkurve_Unten_Links_Enum);
                     
         when KartenVerbesserungDatentypen.Straße_Einzeln_Enum =>
            SchreibeKarten.Weg (KoordinatenExtern => KartenWert,
                                WegExtern         => KartenVerbesserungDatentypen.Straßenendstück_Rechts_Enum);
                     
         when others =>
            null;
      end case;
      
      Wegewert := Wegewert + 100;
      
   end BerechnungRechts;
   
   
   
   procedure BerechnungOben
   is begin
      
      case
        LeseKarten.Weg (KoordinatenExtern => KartenWert)
      is
         when KartenVerbesserungDatentypen.Leer_Weg_Enum =>
            Wegewert := Wegewert - 10;
                     
         when KartenVerbesserungDatentypen.Straße_Waagrecht_Enum =>
            SchreibeKarten.Weg (KoordinatenExtern => KartenWert,
                                WegExtern         => KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Unten_Enum);
                     
         when KartenVerbesserungDatentypen.Straßenkurve_Oben_Rechts_Enum =>
            SchreibeKarten.Weg (KoordinatenExtern => KartenWert,
                                WegExtern         => KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Rechts_Enum);

         when KartenVerbesserungDatentypen.Straßenkurve_Oben_Links_Enum =>
            SchreibeKarten.Weg (KoordinatenExtern => KartenWert,
                                WegExtern         => KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Links_Enum);

         when KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Oben_Enum =>
            SchreibeKarten.Weg (KoordinatenExtern => KartenWert,
                                WegExtern         => KartenVerbesserungDatentypen.Straßenkreuzung_Vier_Enum);

         when KartenVerbesserungDatentypen.Straßenendstück_Links_Enum =>
            SchreibeKarten.Weg (KoordinatenExtern => KartenWert,
                                WegExtern         => KartenVerbesserungDatentypen.Straßenkurve_Unten_Rechts_Enum);

         when KartenVerbesserungDatentypen.Straßenendstück_Rechts_Enum =>
            SchreibeKarten.Weg (KoordinatenExtern => KartenWert,
                                WegExtern         => KartenVerbesserungDatentypen.Straßenkurve_Unten_Links_Enum);

         when KartenVerbesserungDatentypen.Straßenendstück_Unten_Enum =>
            SchreibeKarten.Weg (KoordinatenExtern => KartenWert,
                                WegExtern         => KartenVerbesserungDatentypen.Straße_Senkrecht_Enum);
                     
         when KartenVerbesserungDatentypen.Straße_Einzeln_Enum =>
            SchreibeKarten.Weg (KoordinatenExtern => KartenWert,
                                WegExtern         => KartenVerbesserungDatentypen.Straßenendstück_Oben_Enum);
                     
         when others =>
            null;
      end case;
      
      Wegewert := Wegewert + 10;
      
   end BerechnungOben;
   
   
   
   procedure BerechnungUnten
   is begin
      
      case
        LeseKarten.Weg (KoordinatenExtern => KartenWert)
      is
         when KartenVerbesserungDatentypen.Leer_Weg_Enum =>
            Wegewert := Wegewert - 1;
                     
         when KartenVerbesserungDatentypen.Straße_Waagrecht_Enum =>
            SchreibeKarten.Weg (KoordinatenExtern => KartenWert,
                                WegExtern         => KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Oben_Enum);
                     
         when KartenVerbesserungDatentypen.Straßenkurve_Unten_Rechts_Enum =>
            SchreibeKarten.Weg (KoordinatenExtern => KartenWert,
                                WegExtern         => KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Rechts_Enum);

         when KartenVerbesserungDatentypen.Straßenkurve_Unten_Links_Enum =>
            SchreibeKarten.Weg (KoordinatenExtern => KartenWert,
                                WegExtern         => KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Links_Enum);

         when KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Unten_Enum =>
            SchreibeKarten.Weg (KoordinatenExtern => KartenWert,
                                WegExtern         => KartenVerbesserungDatentypen.Straßenkreuzung_Vier_Enum);

         when KartenVerbesserungDatentypen.Straßenendstück_Links_Enum =>
            SchreibeKarten.Weg (KoordinatenExtern => KartenWert,
                                WegExtern         => KartenVerbesserungDatentypen.Straßenkurve_Oben_Rechts_Enum);

         when KartenVerbesserungDatentypen.Straßenendstück_Rechts_Enum =>
            SchreibeKarten.Weg (KoordinatenExtern => KartenWert,
                                WegExtern         => KartenVerbesserungDatentypen.Straßenkurve_Oben_Links_Enum);

         when KartenVerbesserungDatentypen.Straßenendstück_Oben_Enum =>
            SchreibeKarten.Weg (KoordinatenExtern => KartenWert,
                                WegExtern         => KartenVerbesserungDatentypen.Straße_Senkrecht_Enum);
                     
         when KartenVerbesserungDatentypen.Straße_Einzeln_Enum =>
            SchreibeKarten.Weg (KoordinatenExtern => KartenWert,
                                WegExtern         => KartenVerbesserungDatentypen.Straßenendstück_Unten_Enum);
                     
         when others =>
            null;
      end case;
      
      Wegewert := Wegewert + 1;
      
   end BerechnungUnten;
   
   
   
   procedure WegPlatzieren
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      case
        Wegewert
      is
         when 11_111 =>
            SchreibeKarten.Weg (KoordinatenExtern => KoordinatenExtern,
                                WegExtern         => KartenVerbesserungDatentypen.Straßenkreuzung_Vier_Enum);

         when 11_110 =>
            SchreibeKarten.Weg (KoordinatenExtern => KoordinatenExtern,
                                WegExtern         => KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Oben_Enum);

         when 11_101 =>
            SchreibeKarten.Weg (KoordinatenExtern => KoordinatenExtern,
                                WegExtern         => KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Unten_Enum);
            
         when 11_100 =>
            SchreibeKarten.Weg (KoordinatenExtern => KoordinatenExtern,
                                WegExtern         => KartenVerbesserungDatentypen.Straße_Waagrecht_Enum);
            
         when 11_011 =>
            SchreibeKarten.Weg (KoordinatenExtern => KoordinatenExtern,
                                WegExtern         => KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Links_Enum);

         when 11_010 =>
            SchreibeKarten.Weg (KoordinatenExtern => KoordinatenExtern,
                                WegExtern         => KartenVerbesserungDatentypen.Straßenkurve_Oben_Links_Enum);

         when 11_001 =>
            SchreibeKarten.Weg (KoordinatenExtern => KoordinatenExtern,
                                WegExtern         => KartenVerbesserungDatentypen.Straßenkurve_Unten_Links_Enum);
            
         when 11_000 =>
            SchreibeKarten.Weg (KoordinatenExtern => KoordinatenExtern,
                                WegExtern         => KartenVerbesserungDatentypen.Straßenendstück_Rechts_Enum);

         when 10_111 =>
            SchreibeKarten.Weg (KoordinatenExtern => KoordinatenExtern,
                                WegExtern         => KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Rechts_Enum);

         when 10_110 =>
            SchreibeKarten.Weg (KoordinatenExtern => KoordinatenExtern,
                                WegExtern         => KartenVerbesserungDatentypen.Straßenkurve_Oben_Rechts_Enum);

         when 10_101 =>
            SchreibeKarten.Weg (KoordinatenExtern => KoordinatenExtern,
                                WegExtern         => KartenVerbesserungDatentypen.Straßenkurve_Unten_Rechts_Enum);

         when 10_100 =>
            SchreibeKarten.Weg (KoordinatenExtern => KoordinatenExtern,
                                WegExtern         => KartenVerbesserungDatentypen.Straßenendstück_Links_Enum);

         when 10_011 =>
            SchreibeKarten.Weg (KoordinatenExtern => KoordinatenExtern,
                                WegExtern         => KartenVerbesserungDatentypen.Straße_Senkrecht_Enum);

         when 10_010 =>
            SchreibeKarten.Weg (KoordinatenExtern => KoordinatenExtern,
                                WegExtern         => KartenVerbesserungDatentypen.Straßenendstück_Unten_Enum);

         when 10_001 =>
            SchreibeKarten.Weg (KoordinatenExtern => KoordinatenExtern,
                                WegExtern         => KartenVerbesserungDatentypen.Straßenendstück_Oben_Enum);
         
         when others =>
            SchreibeKarten.Weg (KoordinatenExtern => KoordinatenExtern,
                                WegExtern         => KartenVerbesserungDatentypen.Straße_Einzeln_Enum);
      end case;
      
   end WegPlatzieren;

end VerbesserungWeg;

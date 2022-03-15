pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenVerbesserungDatentypen;
with KartenKonstanten;
with KartenVerbesserungKonstanten;
with TastenbelegungKonstanten;

with SchreibeEinheitenGebaut;
with SchreibeKarten;
with LeseKarten;
with LeseEinheitenGebaut;

with KarteKoordinatenPruefen;
with AufgabenAllgemein;

package body VerbesserungWeg is
   
   -- Hier prüfen welcher Weg
   function VerbesserungWeg
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      GrundExtern : in KartenGrundDatentypen.Karten_Grund_Enum;
      AnlegenTestenExtern : in Boolean)
      return Boolean
   is begin
      
      if
        LeseKarten.VerbesserungWeg (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      in
        KartenVerbesserungDatentypen.Karten_Verbesserung_Weg_Enum'Range
      then
         return False;

      else
         null;
      end if;

      case
        GrundExtern
      is
         when KartenGrundDatentypen.Eis | KartenGrundDatentypen.Flachland | KartenGrundDatentypen.Tundra | KartenGrundDatentypen.Wüste | KartenGrundDatentypen.Hügel | KartenGrundDatentypen.Wald
            | KartenGrundDatentypen.Karten_Grund_Ressourcen_Land'Range =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => TastenbelegungKonstanten.StraßeBauenKonstante);
            SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         ZeitExtern               => 3,
                                                         RechnenSetzenExtern      => 0);

         when KartenGrundDatentypen.Gebirge | KartenGrundDatentypen.Dschungel | KartenGrundDatentypen.Sumpf =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => TastenbelegungKonstanten.StraßeBauenKonstante);
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
            
            KartenWert := KarteKoordinatenPruefen.KarteKoordinatenPrüfen (KoordinatenExtern => KoordinatenExtern,
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
        LeseKarten.VerbesserungWeg (KoordinatenExtern => KartenWert)
      is
         when KartenVerbesserungKonstanten.LeerVerbesserungWeg =>
            Wegewert := Wegewert - 1_000;

         when KartenVerbesserungDatentypen.Straße_Senkrecht =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KartenWert,
                                            WegExtern         => KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Rechts);
                     
         when KartenVerbesserungDatentypen.Straßenkurve_Unten_Links =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KartenWert,
                                            WegExtern         => KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Unten);

         when KartenVerbesserungDatentypen.Straßenkurve_Oben_Links =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KartenWert,
                                            WegExtern         => KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Oben);

         when KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Links =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KartenWert,
                                            WegExtern         => KartenVerbesserungDatentypen.Straßenkreuzung_Vier);

         when KartenVerbesserungDatentypen.Straßenendstück_Rechts =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KartenWert,
                                            WegExtern         => KartenVerbesserungDatentypen.Straße_Waagrecht);

         when KartenVerbesserungDatentypen.Straßenendstück_Unten =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KartenWert,
                                            WegExtern         => KartenVerbesserungDatentypen.Straßenkurve_Oben_Rechts);

         when KartenVerbesserungDatentypen.Straßenendstück_Oben =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KartenWert,
                                            WegExtern         => KartenVerbesserungDatentypen.Straßenkurve_Unten_Rechts);
                     
         when KartenVerbesserungDatentypen.Straße_Einzeln =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KartenWert,
                                            WegExtern         => KartenVerbesserungDatentypen.Straßenendstück_Links);
                     
         when others =>
            null;
      end case;
      
      Wegewert := Wegewert + 1_000;
      
   end BerechnungLinks;
   
   
   
   procedure BerechnungRechts
   is begin
      
      case
        LeseKarten.VerbesserungWeg (KoordinatenExtern => KartenWert)
      is
         when KartenVerbesserungKonstanten.LeerVerbesserungWeg =>
            Wegewert := Wegewert - 100;

         when KartenVerbesserungDatentypen.Straße_Senkrecht =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KartenWert,
                                            WegExtern         => KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Links);
                     
         when KartenVerbesserungDatentypen.Straßenkurve_Unten_Rechts =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KartenWert,
                                            WegExtern         => KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Unten);

         when KartenVerbesserungDatentypen.Straßenkurve_Oben_Rechts =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KartenWert,
                                            WegExtern         => KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Oben);

         when KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Rechts =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KartenWert,
                                            WegExtern         => KartenVerbesserungDatentypen.Straßenkreuzung_Vier);

         when KartenVerbesserungDatentypen.Straßenendstück_Links =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KartenWert,
                                            WegExtern         => KartenVerbesserungDatentypen.Straße_Waagrecht);

         when KartenVerbesserungDatentypen.Straßenendstück_Unten =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KartenWert,
                                            WegExtern         => KartenVerbesserungDatentypen.Straßenkurve_Oben_Links);

         when KartenVerbesserungDatentypen.Straßenendstück_Oben =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KartenWert,
                                            WegExtern         => KartenVerbesserungDatentypen.Straßenkurve_Unten_Links);
                     
         when KartenVerbesserungDatentypen.Straße_Einzeln =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KartenWert,
                                            WegExtern         => KartenVerbesserungDatentypen.Straßenendstück_Rechts);
                     
         when others =>
            null;
      end case;
      
      Wegewert := Wegewert + 100;
      
   end BerechnungRechts;
   
   
   
   procedure BerechnungOben
   is begin
      
      case
        LeseKarten.VerbesserungWeg (KoordinatenExtern => KartenWert)
      is
         when KartenVerbesserungKonstanten.LeerVerbesserungWeg =>
            Wegewert := Wegewert - 10;
                     
         when KartenVerbesserungDatentypen.Straße_Waagrecht =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KartenWert,
                                            WegExtern         => KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Unten);
                     
         when KartenVerbesserungDatentypen.Straßenkurve_Oben_Rechts =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KartenWert,
                                            WegExtern         => KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Rechts);

         when KartenVerbesserungDatentypen.Straßenkurve_Oben_Links =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KartenWert,
                                            WegExtern         => KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Links);

         when KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Oben =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KartenWert,
                                            WegExtern         => KartenVerbesserungDatentypen.Straßenkreuzung_Vier);

         when KartenVerbesserungDatentypen.Straßenendstück_Links =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KartenWert,
                                            WegExtern         => KartenVerbesserungDatentypen.Straßenkurve_Unten_Rechts);

         when KartenVerbesserungDatentypen.Straßenendstück_Rechts =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KartenWert,
                                            WegExtern         => KartenVerbesserungDatentypen.Straßenkurve_Unten_Links);

         when KartenVerbesserungDatentypen.Straßenendstück_Unten =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KartenWert,
                                            WegExtern         => KartenVerbesserungDatentypen.Straße_Senkrecht);
                     
         when KartenVerbesserungDatentypen.Straße_Einzeln =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KartenWert,
                                            WegExtern         => KartenVerbesserungDatentypen.Straßenendstück_Oben);
                     
         when others =>
            null;
      end case;
      
      Wegewert := Wegewert + 10;
      
   end BerechnungOben;
   
   
   
   procedure BerechnungUnten
   is begin
      
      case
        LeseKarten.VerbesserungWeg (KoordinatenExtern => KartenWert)
      is
         when KartenVerbesserungKonstanten.LeerVerbesserungWeg =>
            Wegewert := Wegewert - 1;
                     
         when KartenVerbesserungDatentypen.Straße_Waagrecht =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KartenWert,
                                            WegExtern         => KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Oben);
                     
         when KartenVerbesserungDatentypen.Straßenkurve_Unten_Rechts =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KartenWert,
                                            WegExtern         => KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Rechts);

         when KartenVerbesserungDatentypen.Straßenkurve_Unten_Links =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KartenWert,
                                            WegExtern         => KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Links);

         when KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Unten =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KartenWert,
                                            WegExtern         => KartenVerbesserungDatentypen.Straßenkreuzung_Vier);

         when KartenVerbesserungDatentypen.Straßenendstück_Links =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KartenWert,
                                            WegExtern         => KartenVerbesserungDatentypen.Straßenkurve_Oben_Rechts);

         when KartenVerbesserungDatentypen.Straßenendstück_Rechts =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KartenWert,
                                            WegExtern         => KartenVerbesserungDatentypen.Straßenkurve_Oben_Links);

         when KartenVerbesserungDatentypen.Straßenendstück_Oben =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KartenWert,
                                            WegExtern         => KartenVerbesserungDatentypen.Straße_Senkrecht);
                     
         when KartenVerbesserungDatentypen.Straße_Einzeln =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KartenWert,
                                            WegExtern         => KartenVerbesserungDatentypen.Straßenendstück_Unten);
                     
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
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KoordinatenExtern,
                                            WegExtern         => KartenVerbesserungDatentypen.Straßenkreuzung_Vier);

         when 11_110 =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KoordinatenExtern,
                                            WegExtern         => KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Oben);

         when 11_101 =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KoordinatenExtern,
                                            WegExtern         => KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Unten);
            
         when 11_100 =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KoordinatenExtern,
                                            WegExtern         => KartenVerbesserungDatentypen.Straße_Waagrecht);
            
         when 11_011 =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KoordinatenExtern,
                                            WegExtern         => KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Links);

         when 11_010 =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KoordinatenExtern,
                                            WegExtern         => KartenVerbesserungDatentypen.Straßenkurve_Oben_Links);

         when 11_001 =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KoordinatenExtern,
                                            WegExtern         => KartenVerbesserungDatentypen.Straßenkurve_Unten_Links);
            
         when 11_000 =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KoordinatenExtern,
                                            WegExtern         => KartenVerbesserungDatentypen.Straßenendstück_Rechts);

         when 10_111 =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KoordinatenExtern,
                                            WegExtern         => KartenVerbesserungDatentypen.Straßenkreuzung_Drei_Rechts);

         when 10_110 =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KoordinatenExtern,
                                            WegExtern         => KartenVerbesserungDatentypen.Straßenkurve_Oben_Rechts);

         when 10_101 =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KoordinatenExtern,
                                            WegExtern         => KartenVerbesserungDatentypen.Straßenkurve_Unten_Rechts);

         when 10_100 =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KoordinatenExtern,
                                            WegExtern         => KartenVerbesserungDatentypen.Straßenendstück_Links);

         when 10_011 =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KoordinatenExtern,
                                            WegExtern         => KartenVerbesserungDatentypen.Straße_Senkrecht);

         when 10_010 =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KoordinatenExtern,
                                            WegExtern         => KartenVerbesserungDatentypen.Straßenendstück_Unten);

         when 10_001 =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KoordinatenExtern,
                                            WegExtern         => KartenVerbesserungDatentypen.Straßenendstück_Oben);
         
         when others =>
            SchreibeKarten.VerbesserungWeg (KoordinatenExtern => KoordinatenExtern,
                                            WegExtern         => KartenVerbesserungDatentypen.Straße_Einzeln);
      end case;
      
   end WegPlatzieren;

end VerbesserungWeg;

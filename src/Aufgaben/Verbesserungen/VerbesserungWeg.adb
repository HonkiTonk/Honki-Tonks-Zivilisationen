pragma SPARK_Mode (On);

with KartenKonstanten;

with SchreibeEinheitenGebaut, SchreibeKarten;
with LeseKarten, LeseEinheitenGebaut;

with KartePositionPruefen, AufgabenAllgemein;

package body VerbesserungWeg is
   
   -- Hier prüfen welcher Weg
   function VerbesserungWeg
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      GrundExtern : in GlobaleDatentypen.Karten_Grund_Enum;
      AnlegenTestenExtern : in Boolean)
      return Boolean
   is begin
      
      if
        LeseKarten.VerbesserungWeg (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      in
        GlobaleDatentypen.Karten_Verbesserung_Weg_Enum'Range
      then
         return False;

      else
         null;
      end if;

      case
        GrundExtern
      is
         when GlobaleDatentypen.Eis | GlobaleDatentypen.Flachland | GlobaleDatentypen.Tundra | GlobaleDatentypen.Wüste | GlobaleDatentypen.Hügel | GlobaleDatentypen.Wald
            | GlobaleDatentypen.Karten_Grund_Ressourcen_Land'Range =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => GlobaleDatentypen.Straße_Bauen);
            SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         ZeitExtern               => 3,
                                                         RechnenSetzenExtern      => 0);

         when GlobaleDatentypen.Gebirge | GlobaleDatentypen.Dschungel | GlobaleDatentypen.Sumpf =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => GlobaleDatentypen.Straße_Bauen);
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
      for YÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => KoordinatenExtern,
                                                                        ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert));
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerYXKartenWert
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
        LeseKarten.VerbesserungWeg (PositionExtern => KartenWert)
      is
         when GlobaleDatentypen.Leer =>
            Wegewert := Wegewert - 1_000;

         when GlobaleDatentypen.Straße_Senkrecht =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => GlobaleDatentypen.Straßenkreuzung_Drei_Rechts);
                     
         when GlobaleDatentypen.Straßenkurve_Unten_Links =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => GlobaleDatentypen.Straßenkreuzung_Drei_Unten);

         when GlobaleDatentypen.Straßenkurve_Oben_Links =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => GlobaleDatentypen.Straßenkreuzung_Drei_Oben);

         when GlobaleDatentypen.Straßenkreuzung_Drei_Links =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => GlobaleDatentypen.Straßenkreuzung_Vier);

         when GlobaleDatentypen.Straßenendstück_Rechts =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => GlobaleDatentypen.Straße_Waagrecht);

         when GlobaleDatentypen.Straßenendstück_Unten =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => GlobaleDatentypen.Straßenkurve_Oben_Rechts);

         when GlobaleDatentypen.Straßenendstück_Oben =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => GlobaleDatentypen.Straßenkurve_Unten_Rechts);
                     
         when GlobaleDatentypen.Straße_Einzeln =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => GlobaleDatentypen.Straßenendstück_Links);
                     
         when others =>
            null;
      end case;
      Wegewert := Wegewert + 1_000;
      
   end BerechnungLinks;
   
   
   
   procedure BerechnungRechts
   is begin
      
      case
        LeseKarten.VerbesserungWeg (PositionExtern => KartenWert)
      is
         when GlobaleDatentypen.Leer =>
            Wegewert := Wegewert - 100;

         when GlobaleDatentypen.Straße_Senkrecht =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => GlobaleDatentypen.Straßenkreuzung_Drei_Links);
                     
         when GlobaleDatentypen.Straßenkurve_Unten_Rechts =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => GlobaleDatentypen.Straßenkreuzung_Drei_Unten);

         when GlobaleDatentypen.Straßenkurve_Oben_Rechts =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => GlobaleDatentypen.Straßenkreuzung_Drei_Oben);

         when GlobaleDatentypen.Straßenkreuzung_Drei_Rechts =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => GlobaleDatentypen.Straßenkreuzung_Vier);

         when GlobaleDatentypen.Straßenendstück_Links =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => GlobaleDatentypen.Straße_Waagrecht);

         when GlobaleDatentypen.Straßenendstück_Unten =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => GlobaleDatentypen.Straßenkurve_Oben_Links);

         when GlobaleDatentypen.Straßenendstück_Oben =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => GlobaleDatentypen.Straßenkurve_Unten_Links);
                     
         when GlobaleDatentypen.Straße_Einzeln =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => GlobaleDatentypen.Straßenendstück_Rechts);
                     
         when others =>
            null;
      end case;
      Wegewert := Wegewert + 100;
      
   end BerechnungRechts;
   
   
   
   procedure BerechnungOben
   is begin
      
      case
        LeseKarten.VerbesserungWeg (PositionExtern => KartenWert)
      is
         when GlobaleDatentypen.Leer =>
            Wegewert := Wegewert - 10;
                     
         when GlobaleDatentypen.Straße_Waagrecht =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => GlobaleDatentypen.Straßenkreuzung_Drei_Unten);
                     
         when GlobaleDatentypen.Straßenkurve_Oben_Rechts =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => GlobaleDatentypen.Straßenkreuzung_Drei_Rechts);

         when GlobaleDatentypen.Straßenkurve_Oben_Links =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => GlobaleDatentypen.Straßenkreuzung_Drei_Links);

         when GlobaleDatentypen.Straßenkreuzung_Drei_Oben =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => GlobaleDatentypen.Straßenkreuzung_Vier);

         when GlobaleDatentypen.Straßenendstück_Links =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => GlobaleDatentypen.Straßenkurve_Unten_Rechts);

         when GlobaleDatentypen.Straßenendstück_Rechts =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => GlobaleDatentypen.Straßenkurve_Unten_Links);

         when GlobaleDatentypen.Straßenendstück_Unten =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => GlobaleDatentypen.Straße_Senkrecht);
                     
         when GlobaleDatentypen.Straße_Einzeln =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => GlobaleDatentypen.Straßenendstück_Oben);
                     
         when others =>
            null;
      end case;
      Wegewert := Wegewert + 10;
      
   end BerechnungOben;
   
   
   
   procedure BerechnungUnten
   is begin
      
      case
        LeseKarten.VerbesserungWeg (PositionExtern => KartenWert)
      is
         when GlobaleDatentypen.Leer =>
            Wegewert := Wegewert - 1;
                     
         when GlobaleDatentypen.Straße_Waagrecht =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => GlobaleDatentypen.Straßenkreuzung_Drei_Oben);
                     
         when GlobaleDatentypen.Straßenkurve_Unten_Rechts =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => GlobaleDatentypen.Straßenkreuzung_Drei_Rechts);

         when GlobaleDatentypen.Straßenkurve_Unten_Links =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => GlobaleDatentypen.Straßenkreuzung_Drei_Links);

         when GlobaleDatentypen.Straßenkreuzung_Drei_Unten =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => GlobaleDatentypen.Straßenkreuzung_Vier);

         when GlobaleDatentypen.Straßenendstück_Links =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => GlobaleDatentypen.Straßenkurve_Oben_Rechts);

         when GlobaleDatentypen.Straßenendstück_Rechts =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => GlobaleDatentypen.Straßenkurve_Oben_Links);

         when GlobaleDatentypen.Straßenendstück_Oben =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => GlobaleDatentypen.Straße_Senkrecht);
                     
         when GlobaleDatentypen.Straße_Einzeln =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => GlobaleDatentypen.Straßenendstück_Unten);
                     
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
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => GlobaleDatentypen.Straßenkreuzung_Vier);

         when 11_110 =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => GlobaleDatentypen.Straßenkreuzung_Drei_Oben);

         when 11_101 =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => GlobaleDatentypen.Straßenkreuzung_Drei_Unten);
            
         when 11_100 =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => GlobaleDatentypen.Straße_Waagrecht);
            
         when 11_011 =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => GlobaleDatentypen.Straßenkreuzung_Drei_Links);

         when 11_010 =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => GlobaleDatentypen.Straßenkurve_Oben_Links);

         when 11_001 =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => GlobaleDatentypen.Straßenkurve_Unten_Links);
            
         when 11_000 =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => GlobaleDatentypen.Straßenendstück_Rechts);

         when 10_111 =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => GlobaleDatentypen.Straßenkreuzung_Drei_Rechts);

         when 10_110 =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => GlobaleDatentypen.Straßenkurve_Oben_Rechts);

         when 10_101 =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => GlobaleDatentypen.Straßenkurve_Unten_Rechts);

         when 10_100 =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => GlobaleDatentypen.Straßenendstück_Links);

         when 10_011 =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => GlobaleDatentypen.Straße_Senkrecht);

         when 10_010 =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => GlobaleDatentypen.Straßenendstück_Unten);

         when 10_001 =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => GlobaleDatentypen.Straßenendstück_Oben);
         
         when others =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => GlobaleDatentypen.Straße_Einzeln);
      end case;
      
   end WegPlatzieren;

end VerbesserungWeg;

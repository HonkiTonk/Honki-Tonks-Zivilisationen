pragma SPARK_Mode (On);

with SystemDatentypen;
with KartenKonstanten;

with SchreibeEinheitenGebaut;
with SchreibeKarten;
with LeseKarten;
with LeseEinheitenGebaut;

with KartePositionPruefen;
with AufgabenAllgemein;

package body VerbesserungWeg is
   
   -- Hier prüfen welcher Weg
   function VerbesserungWeg
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      GrundExtern : in KartenDatentypen.Karten_Grund_Enum;
      AnlegenTestenExtern : in Boolean)
      return Boolean
   is begin
      
      if
        LeseKarten.VerbesserungWeg (PositionExtern => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      in
        KartenDatentypen.Karten_Verbesserung_Weg_Enum'Range
      then
         return False;

      else
         null;
      end if;

      case
        GrundExtern
      is
         when KartenDatentypen.Eis | KartenDatentypen.Flachland | KartenDatentypen.Tundra | KartenDatentypen.Wüste | KartenDatentypen.Hügel | KartenDatentypen.Wald
            | KartenDatentypen.Karten_Grund_Ressourcen_Land'Range =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => SystemDatentypen.Straße_Bauen);
            SchreibeEinheitenGebaut.Beschäftigungszeit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                         ZeitExtern               => 3,
                                                         RechnenSetzenExtern      => 0);

         when KartenDatentypen.Gebirge | KartenDatentypen.Dschungel | KartenDatentypen.Sumpf =>
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern     => SystemDatentypen.Straße_Bauen);
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
      for YÄnderungSchleifenwert in KartenDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in KartenDatentypen.LoopRangeMinusEinsZuEins'Range loop
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => KoordinatenExtern,
                                                                        ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert));
            
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
        LeseKarten.VerbesserungWeg (PositionExtern => KartenWert)
      is
         when KartenDatentypen.Leer =>
            Wegewert := Wegewert - 1_000;

         when KartenDatentypen.Straße_Senkrecht =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => KartenDatentypen.Straßenkreuzung_Drei_Rechts);
                     
         when KartenDatentypen.Straßenkurve_Unten_Links =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => KartenDatentypen.Straßenkreuzung_Drei_Unten);

         when KartenDatentypen.Straßenkurve_Oben_Links =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => KartenDatentypen.Straßenkreuzung_Drei_Oben);

         when KartenDatentypen.Straßenkreuzung_Drei_Links =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => KartenDatentypen.Straßenkreuzung_Vier);

         when KartenDatentypen.Straßenendstück_Rechts =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => KartenDatentypen.Straße_Waagrecht);

         when KartenDatentypen.Straßenendstück_Unten =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => KartenDatentypen.Straßenkurve_Oben_Rechts);

         when KartenDatentypen.Straßenendstück_Oben =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => KartenDatentypen.Straßenkurve_Unten_Rechts);
                     
         when KartenDatentypen.Straße_Einzeln =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => KartenDatentypen.Straßenendstück_Links);
                     
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
         when KartenDatentypen.Leer =>
            Wegewert := Wegewert - 100;

         when KartenDatentypen.Straße_Senkrecht =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => KartenDatentypen.Straßenkreuzung_Drei_Links);
                     
         when KartenDatentypen.Straßenkurve_Unten_Rechts =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => KartenDatentypen.Straßenkreuzung_Drei_Unten);

         when KartenDatentypen.Straßenkurve_Oben_Rechts =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => KartenDatentypen.Straßenkreuzung_Drei_Oben);

         when KartenDatentypen.Straßenkreuzung_Drei_Rechts =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => KartenDatentypen.Straßenkreuzung_Vier);

         when KartenDatentypen.Straßenendstück_Links =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => KartenDatentypen.Straße_Waagrecht);

         when KartenDatentypen.Straßenendstück_Unten =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => KartenDatentypen.Straßenkurve_Oben_Links);

         when KartenDatentypen.Straßenendstück_Oben =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => KartenDatentypen.Straßenkurve_Unten_Links);
                     
         when KartenDatentypen.Straße_Einzeln =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => KartenDatentypen.Straßenendstück_Rechts);
                     
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
         when KartenDatentypen.Leer =>
            Wegewert := Wegewert - 10;
                     
         when KartenDatentypen.Straße_Waagrecht =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => KartenDatentypen.Straßenkreuzung_Drei_Unten);
                     
         when KartenDatentypen.Straßenkurve_Oben_Rechts =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => KartenDatentypen.Straßenkreuzung_Drei_Rechts);

         when KartenDatentypen.Straßenkurve_Oben_Links =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => KartenDatentypen.Straßenkreuzung_Drei_Links);

         when KartenDatentypen.Straßenkreuzung_Drei_Oben =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => KartenDatentypen.Straßenkreuzung_Vier);

         when KartenDatentypen.Straßenendstück_Links =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => KartenDatentypen.Straßenkurve_Unten_Rechts);

         when KartenDatentypen.Straßenendstück_Rechts =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => KartenDatentypen.Straßenkurve_Unten_Links);

         when KartenDatentypen.Straßenendstück_Unten =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => KartenDatentypen.Straße_Senkrecht);
                     
         when KartenDatentypen.Straße_Einzeln =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => KartenDatentypen.Straßenendstück_Oben);
                     
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
         when KartenDatentypen.Leer =>
            Wegewert := Wegewert - 1;
                     
         when KartenDatentypen.Straße_Waagrecht =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => KartenDatentypen.Straßenkreuzung_Drei_Oben);
                     
         when KartenDatentypen.Straßenkurve_Unten_Rechts =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => KartenDatentypen.Straßenkreuzung_Drei_Rechts);

         when KartenDatentypen.Straßenkurve_Unten_Links =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => KartenDatentypen.Straßenkreuzung_Drei_Links);

         when KartenDatentypen.Straßenkreuzung_Drei_Unten =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => KartenDatentypen.Straßenkreuzung_Vier);

         when KartenDatentypen.Straßenendstück_Links =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => KartenDatentypen.Straßenkurve_Oben_Rechts);

         when KartenDatentypen.Straßenendstück_Rechts =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => KartenDatentypen.Straßenkurve_Oben_Links);

         when KartenDatentypen.Straßenendstück_Oben =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => KartenDatentypen.Straße_Senkrecht);
                     
         when KartenDatentypen.Straße_Einzeln =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KartenWert,
                                            WegExtern      => KartenDatentypen.Straßenendstück_Unten);
                     
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
                                            WegExtern      => KartenDatentypen.Straßenkreuzung_Vier);

         when 11_110 =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => KartenDatentypen.Straßenkreuzung_Drei_Oben);

         when 11_101 =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => KartenDatentypen.Straßenkreuzung_Drei_Unten);
            
         when 11_100 =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => KartenDatentypen.Straße_Waagrecht);
            
         when 11_011 =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => KartenDatentypen.Straßenkreuzung_Drei_Links);

         when 11_010 =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => KartenDatentypen.Straßenkurve_Oben_Links);

         when 11_001 =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => KartenDatentypen.Straßenkurve_Unten_Links);
            
         when 11_000 =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => KartenDatentypen.Straßenendstück_Rechts);

         when 10_111 =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => KartenDatentypen.Straßenkreuzung_Drei_Rechts);

         when 10_110 =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => KartenDatentypen.Straßenkurve_Oben_Rechts);

         when 10_101 =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => KartenDatentypen.Straßenkurve_Unten_Rechts);

         when 10_100 =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => KartenDatentypen.Straßenendstück_Links);

         when 10_011 =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => KartenDatentypen.Straße_Senkrecht);

         when 10_010 =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => KartenDatentypen.Straßenendstück_Unten);

         when 10_001 =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => KartenDatentypen.Straßenendstück_Oben);
         
         when others =>
            SchreibeKarten.VerbesserungWeg (PositionExtern => KoordinatenExtern,
                                            WegExtern      => KartenDatentypen.Straße_Einzeln);
      end case;
      
   end WegPlatzieren;

end VerbesserungWeg;

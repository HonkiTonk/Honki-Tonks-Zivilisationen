pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenGrundDatentypen; use KartenGrundDatentypen;
with KartenKonstanten;

with SchreibeKarten;
with LeseKarten;

with KartenGeneratorBerechnungenAllgemein; use KartenGeneratorBerechnungenAllgemein;
with ZufallsgeneratorenKarten;
with Kartenkoordinatenberechnungssystem;
with KartengeneratorVariablen;

package body KartenGeneratorLandschaft is

   procedure GenerierungLandschaft
   is begin
      
      case
        Karten.Kartenparameter.Kartenart
      is
         when KartenDatentypen.Kartenart_Chaotisch_Enum'Range =>
            return;
            
         when others =>
            null;
      end case;
                  
      YAchseSchleife:
      for YAchseSchleifenwert in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.YAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.XAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.XAchse loop
            
            case
              LeseKarten.Grund (KoordinatenExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert))
            is
               when KartenGrundDatentypen.Flachland_Enum =>
                  GrundBestimmen (YAchseExtern => YAchseSchleifenwert,
                                  XAchseExtern => XAchseSchleifenwert);

               when others =>
                  null;
            end case;
                        
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end GenerierungLandschaft;
   
   
   
   procedure GrundBestimmen
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
   is begin
      
      ZufallszahlenSchleife:
      for ZufallszahlSchleifenwert in KartengrundWahrscheinlichkeitArray'Range loop
         
         GezogeneZahlen (ZufallszahlSchleifenwert) := ZufallsgeneratorenKarten.ZufälligerWert;
         
      end loop ZufallszahlenSchleife;
      
      WelcherGrund := KartenGrundDatentypen.Leer_Grund_Enum;
      WelcheMöglichkeiten := (others => False);
      
      AuswahlSchleife:
      for AuswahlSchleifenwert in KartengrundWahrscheinlichkeitArray'Range loop
         
         if
           GezogeneZahlen (AuswahlSchleifenwert) < KartengrundWahrscheinlichkeit (AuswahlSchleifenwert)
         then
            WelcheMöglichkeiten (AuswahlSchleifenwert) := True;
            
         else
            null;
         end if;
         
      end loop AuswahlSchleife;
      
      ------------------- Braucht noch ein wenig Feinabstimmung.
      ErsteSchleife:
      for ErsterSchleifenwert in KartengrundWahrscheinlichkeitArray'Range loop
         ZweiteSchleife:
         for ZweiterSchleifenwert in KartengrundWahrscheinlichkeitArray'Range loop
            
            if
              WelcheMöglichkeiten (ErsterSchleifenwert) = False
              or
                WelcheMöglichkeiten (ZweiterSchleifenwert) = False
            then
               null;
               
            elsif
              GezogeneZahlen (ErsterSchleifenwert) >= GezogeneZahlen (ZweiterSchleifenwert)
            then
               WelcherGrund := ErsterSchleifenwert;
               
            else
               WelcherGrund := ZweiterSchleifenwert;
            end if;
            
         end loop ZweiteSchleife;
      end loop ErsteSchleife;
      
      WelcherGrund := GrundErneutBestimmen (GrundExtern => WelcherGrund);
      
      WelcherGrund := GrundZusatzberechnungen (YAchseExtern => YAchseExtern,
                                               XAchseExtern => XAchseExtern,
                                               GrundExtern  => WelcherGrund);
      
      SchreibeKarten.Grund (KoordinatenExtern => (0, YAchseExtern, XAchseExtern),
                            GrundExtern       => WelcherGrund);
      
      WeitereHügel (YAchseExtern => YAchseExtern,
                     XAchseExtern => XAchseExtern);
      
   end GrundBestimmen;
   
   
   
   function GrundErneutBestimmen
     (GrundExtern : in KartenGrundDatentypen.Karten_Grund_Enum)
      return KartenGrundDatentypen.Karten_Grund_Generator_Enum
   is begin
      
      case
        GrundExtern
      is
         when KartenGrundDatentypen.Leer_Grund_Enum =>
            null;
            
         when others =>
            return GrundExtern;
      end case;
      
      ------------------- Braucht noch ein wenig Feinabstimmung.
      ErsteSchleife:
      for ErsterSchleifenwert in KartengrundWahrscheinlichkeitArray'Range loop
         ZweiteSchleife:
         for ZweiterSchleifenwert in KartengrundWahrscheinlichkeitArray'Range loop
            
            if
              GezogeneZahlen (ErsterSchleifenwert) >= GezogeneZahlen (ZweiterSchleifenwert)
            then
               NeuerGrund := ErsterSchleifenwert;
               
            else
               NeuerGrund := ZweiterSchleifenwert;
            end if;
            
         end loop ZweiteSchleife;
      end loop ErsteSchleife;
      
      return NeuerGrund;
      
   end GrundErneutBestimmen;
   
   
   
   function GrundZusatzberechnungen
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartenGrundDatentypen.Karten_Grund_Generator_Enum)
      return KartenGrundDatentypen.Karten_Grund_Generator_Enum
   is begin
      
      if
        YAchseExtern = XAchseExtern
      then
         null;
         
      else
         null;
      end if;
      
      -------------------------- Bei allen Berechnungen das Eis berücksichtigen?
      case
        GrundExtern
      is
         when KartenGrundDatentypen.Tundra_Enum =>
            ZusatzberechnungenGrund := ZusatzberechnungTundra (YAchseExtern => YAchseExtern,
                                                               XAchseExtern => XAchseExtern,
                                                               GrundExtern  => GrundExtern);
            
         when KartenGrundDatentypen.Wüste_Enum =>
            ZusatzberechnungenGrund := ZusatzberechnungWüste (YAchseExtern => YAchseExtern,
                                                               XAchseExtern => XAchseExtern,
                                                               GrundExtern  => GrundExtern);
            
         when KartenGrundDatentypen.Hügel_Enum =>
            ZusatzberechnungenGrund := ZusatzberechnungHügel (YAchseExtern => YAchseExtern,
                                                               XAchseExtern => XAchseExtern,
                                                               GrundExtern  => GrundExtern);
            
         when KartenGrundDatentypen.Gebirge_Enum =>
            ZusatzberechnungenGrund := ZusatzberechnungGebirge (YAchseExtern => YAchseExtern,
                                                                XAchseExtern => XAchseExtern,
                                                                GrundExtern  => GrundExtern);
            
         when KartenGrundDatentypen.Wald_Enum =>
            ZusatzberechnungenGrund := ZusatzberechnungWald (YAchseExtern => YAchseExtern,
                                                             XAchseExtern => XAchseExtern,
                                                             GrundExtern  => GrundExtern);
            
         when KartenGrundDatentypen.Dschungel_Enum =>
            ZusatzberechnungenGrund := ZusatzberechnungDschungel (YAchseExtern => YAchseExtern,
                                                                  XAchseExtern => XAchseExtern,
                                                                  GrundExtern  => GrundExtern);
            
         when KartenGrundDatentypen.Sumpf_Enum =>
            ZusatzberechnungenGrund := ZusatzberechnungSumpf (YAchseExtern => YAchseExtern,
                                                              XAchseExtern => XAchseExtern,
                                                              GrundExtern  => GrundExtern);
            
         when KartenGrundDatentypen.Flachland_Enum =>
            ZusatzberechnungenGrund := ZusatzberechnungFlachland (YAchseExtern => YAchseExtern,
                                                                  XAchseExtern => XAchseExtern,
                                                                  GrundExtern  => GrundExtern);
      end case;
      
      return ZusatzberechnungenGrund;
      
   end GrundZusatzberechnungen;
   
   
   
   function ZusatzberechnungTundra
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartenGrundDatentypen.Karten_Grund_Generator_Enum)
      return KartenGrundDatentypen.Karten_Grund_Generator_Enum
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
            
            KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => (0, YAchseExtern, XAchseExtern),
                                                                                                 ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                 LogikGrafikExtern => True);
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              LeseKarten.Grund (KoordinatenExtern => KartenWert) = KartenGrundDatentypen.Wüste_Enum
            then
               return KartenGrundDatentypen.Wüste_Enum;
                  
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      return GrundExtern;
      
   end ZusatzberechnungTundra;
   
   
   
   function ZusatzberechnungWüste
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartenGrundDatentypen.Karten_Grund_Generator_Enum)
      return KartenGrundDatentypen.Karten_Grund_Generator_Enum
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
            
            KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => (0, YAchseExtern, XAchseExtern),
                                                                                                 ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                 LogikGrafikExtern => True);
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              LeseKarten.Grund (KoordinatenExtern => KartenWert) = KartenGrundDatentypen.Eis_Enum
              or
                LeseKarten.Grund (KoordinatenExtern => KartenWert) = KartenGrundDatentypen.Tundra_Enum
            then
               return KartenGrundDatentypen.Tundra_Enum;
                  
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      return GrundExtern;
      
   end ZusatzberechnungWüste;
   
   
   
   function ZusatzberechnungHügel
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartenGrundDatentypen.Karten_Grund_Generator_Enum)
      return KartenGrundDatentypen.Karten_Grund_Generator_Enum
   is begin
      
      if
        YAchseExtern = XAchseExtern
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungHügel;
   
   
   
   function ZusatzberechnungGebirge
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartenGrundDatentypen.Karten_Grund_Generator_Enum)
      return KartenGrundDatentypen.Karten_Grund_Generator_Enum
   is begin
      
      if
        YAchseExtern = XAchseExtern
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungGebirge;
   
   
   
   function ZusatzberechnungWald
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartenGrundDatentypen.Karten_Grund_Generator_Enum)
      return KartenGrundDatentypen.Karten_Grund_Generator_Enum
   is begin
      
      if
        YAchseExtern = XAchseExtern
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungWald;
   
   
   
   function ZusatzberechnungDschungel
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartenGrundDatentypen.Karten_Grund_Generator_Enum)
      return KartenGrundDatentypen.Karten_Grund_Generator_Enum
   is begin
      
      if
        YAchseExtern = XAchseExtern
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungDschungel;
   
   
   
   function ZusatzberechnungSumpf
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartenGrundDatentypen.Karten_Grund_Generator_Enum)
      return KartenGrundDatentypen.Karten_Grund_Generator_Enum
   is begin
      
      if
        YAchseExtern = XAchseExtern
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungSumpf;
   
   
   
   function ZusatzberechnungFlachland
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartenGrundDatentypen.Karten_Grund_Generator_Enum)
      return KartenGrundDatentypen.Karten_Grund_Generator_Enum
   is begin
      
      if
        YAchseExtern = XAchseExtern
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungFlachland;
   
   
   
   procedure WeitereHügel
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
   is begin
      
      AnzahlGleicherGrund := KartenGeneratorBerechnungenAllgemein.GleicherGrundAnzahlBestimmen (KoordinatenExtern => (0, YAchseExtern, XAchseExtern),
                                                                                                GrundExtern       => KartenGrundDatentypen.Gebirge_Enum,
                                                                                                EbeneExtern       => 0)
        + KartenGeneratorBerechnungenAllgemein.GleicherGrundAnzahlBestimmen (KoordinatenExtern => (0, YAchseExtern, XAchseExtern),
                                                                             GrundExtern       => KartenGrundDatentypen.Hügel_Enum,
                                                                             EbeneExtern       => 0);
      
      if
        ZufallsgeneratorenKarten.ZufälligerWert <= ZusatzHügel (AnzahlGleicherGrund)
      then
         SchreibeKarten.Hügel (KoordinatenExtern => (0, YAchseExtern, XAchseExtern),
                                HügelExtern       => True);
         
      else
         null;
      end if;
      
   end WeitereHügel;

end KartenGeneratorLandschaft;

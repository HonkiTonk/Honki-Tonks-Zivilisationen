pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SchreibeKarten;

with ZufallsgeneratorenKarten;

package body KartengeneratorWasserwelt is

   procedure KartengeneratorWasserwelt
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
   is begin
      
      ZufallszahlenSchleife:
      for ZufallszahlSchleifenwert in KartengrundWahrscheinlichkeitArray'Range loop
         
         GezogeneZahlen (ZufallszahlSchleifenwert) := ZufallsgeneratorenKarten.KartengeneratorZufallswerte;
         
      end loop ZufallszahlenSchleife;
      
      WelcherGrund := KartengrundDatentypen.Leer_Grund_Enum;
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
      
      SchreibeKarten.AktuellerGrund (KoordinatenExtern => (-1, YAchseExtern, XAchseExtern),
                            GrundExtern       => WelcherGrund);
      
   end KartengeneratorWasserwelt;
   
   
   
   function GrundErneutBestimmen
     (GrundExtern : in KartengrundDatentypen.Kartengrund_Enum)
      return KartengrundDatentypen.Kartengrund_Unterfläche_Wasser_Variabel_Enum
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Leer_Grund_Enum =>
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
      GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Wasser_Variabel_Enum)
      return KartengrundDatentypen.Kartengrund_Unterfläche_Wasser_Variabel_Enum
   is begin
      
      -------------------------- Bei allen Berechnungen das Eis berücksichtigen?
      case
        GrundExtern
      is
         when KartengrundDatentypen.Meeresgrund_Enum =>
            ZusatzberechnungenGrund := ZusatzberechnungMeeresgrund (YAchseExtern => YAchseExtern,
                                                                    XAchseExtern => XAchseExtern,
                                                                    GrundExtern  => GrundExtern);
            
         when KartengrundDatentypen.Korallen_Enum =>
            ZusatzberechnungenGrund := ZusatzberechnungKorallen (YAchseExtern => YAchseExtern,
                                                                 XAchseExtern => XAchseExtern,
                                                                 GrundExtern  => GrundExtern);
            
         when KartengrundDatentypen.Unterwald_Enum =>
            ZusatzberechnungenGrund := ZusatzberechnungUnterwald (YAchseExtern => YAchseExtern,
                                                                  XAchseExtern => XAchseExtern,
                                                                  GrundExtern  => GrundExtern);
      end case;
      
      return ZusatzberechnungenGrund;
      
   end GrundZusatzberechnungen;
   
   
   
   function ZusatzberechnungMeeresgrund
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Wasser_Variabel_Enum)
      return KartengrundDatentypen.Kartengrund_Unterfläche_Wasser_Variabel_Enum
   is begin
      
      if
        YAchseExtern = XAchseExtern
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungMeeresgrund;
   
   
   
   function ZusatzberechnungKorallen
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Wasser_Variabel_Enum)
      return KartengrundDatentypen.Kartengrund_Unterfläche_Wasser_Variabel_Enum
   is begin
      
      if
        YAchseExtern = XAchseExtern
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungKorallen;
   
   
   
   function ZusatzberechnungUnterwald
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Wasser_Variabel_Enum)
      return KartengrundDatentypen.Kartengrund_Unterfläche_Wasser_Variabel_Enum
   is begin
      
      if
        YAchseExtern = XAchseExtern
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungUnterwald;

end KartengeneratorWasserwelt;

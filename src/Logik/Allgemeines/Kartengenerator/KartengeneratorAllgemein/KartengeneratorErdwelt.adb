pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SchreibeKarten;

with ZufallsgeneratorenKarten;

package body KartengeneratorErdwelt is

   procedure KartengeneratorErdwelt
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
      
   end KartengeneratorErdwelt;
   
   
   
   function GrundErneutBestimmen
     (GrundExtern : in KartengrundDatentypen.Kartengrund_Enum)
      return KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum
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
      GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum)
      return KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum
   is begin
      
      -------------------------- Bei allen Berechnungen das Eis berücksichtigen?
      case
        GrundExtern
      is
         when KartengrundDatentypen.Erde_Enum =>
            ZusatzberechnungenGrund := ZusatzberechnungErde (YAchseExtern => YAchseExtern,
                                                             XAchseExtern => XAchseExtern,
                                                             GrundExtern  => GrundExtern);
            
         when KartengrundDatentypen.Erdgestein_Enum =>
            ZusatzberechnungenGrund := ZusatzberechnungErdgestein (YAchseExtern => YAchseExtern,
                                                                   XAchseExtern => XAchseExtern,
                                                                   GrundExtern  => GrundExtern);
            
         when KartengrundDatentypen.Sand_Enum =>
            ZusatzberechnungenGrund := ZusatzberechnungSand (YAchseExtern => YAchseExtern,
                                                             XAchseExtern => XAchseExtern,
                                                             GrundExtern  => GrundExtern);
            
         when KartengrundDatentypen.Gestein_Enum =>
            ZusatzberechnungenGrund := ZusatzberechnungGestein (YAchseExtern => YAchseExtern,
                                                                XAchseExtern => XAchseExtern,
                                                                GrundExtern  => GrundExtern);
      end case;
      
      return ZusatzberechnungenGrund;
      
   end GrundZusatzberechnungen;
   
   
   
   function ZusatzberechnungErde
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum)
      return KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum
   is begin
      
      if
        YAchseExtern = XAchseExtern
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungErde;
   
   
   
   function ZusatzberechnungErdgestein
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum)
      return KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum
   is begin
      
      if
        YAchseExtern = XAchseExtern
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungErdgestein;
   
   
   
   function ZusatzberechnungSand
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum)
      return KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum
   is begin
      
      if
        YAchseExtern = XAchseExtern
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungSand;
   
   
   
   function ZusatzberechnungGestein
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum)
      return KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum
   is begin
      
      if
        YAchseExtern = XAchseExtern
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungGestein;

end KartengeneratorErdwelt;

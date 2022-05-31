pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen; use KartengrundDatentypen;
with KartenKonstanten;

with SchreibeKarten;
with LeseKarten;

with ZufallsgeneratorenKarten;
with Kartenkoordinatenberechnungssystem;
with KartengeneratorVariablen;

package body KartengeneratorLandschaft is

   procedure GenerierungLandschaft
   is begin
      
      BasisYAchseSchleife:
      for BasisYAchseSchleifenwert in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.YAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.YAchse loop
         BasisXAchseSchleife:
         for BasisXAchseSchleifenwert in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.XAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.XAchse loop
            
            case
              LeseKarten.AktuellerGrund (KoordinatenExtern => (0, BasisYAchseSchleifenwert, BasisXAchseSchleifenwert))
            is
               when KartengrundDatentypen.Flachland_Enum =>
                  BasisgrundBestimmen (YAchseExtern => BasisYAchseSchleifenwert,
                                       XAchseExtern => BasisXAchseSchleifenwert);

               when others =>
                  null;
            end case;
                        
         end loop BasisXAchseSchleife;
      end loop BasisYAchseSchleife;
      
      
      
      ZusatzYAchseSchleife:
      for ZusatzYAchseSchleifenwert in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.YAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.YAchse loop
         ZusatzXAchseSchleife:
         for ZusatzXAchseSchleifenwert in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.XAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.XAchse loop
            
            case
              LeseKarten.AktuellerGrund (KoordinatenExtern => (0, ZusatzYAchseSchleifenwert, ZusatzXAchseSchleifenwert))
            is
               when KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum =>
                  ZusatzgrundBestimmen (YAchseExtern => ZusatzYAchseSchleifenwert,
                                        XAchseExtern => ZusatzXAchseSchleifenwert);

               when others =>
                  null;
            end case;
            
         end loop ZusatzXAchseSchleife;
      end loop ZusatzYAchseSchleife;
      
   end GenerierungLandschaft;
   
   
   
   procedure BasisgrundBestimmen
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
   is begin
      
      WelcherGrund := KartengrundDatentypen.Leer_Grund_Enum;
      
      ZufallszahlenSchleife:
      for ZufallszahlSchleifenwert in BasisWahrscheinlichkeitenArray'Range loop
         
         BasisZahlen (ZufallszahlSchleifenwert) := ZufallsgeneratorenKarten.KartengeneratorZufallswerte;
         
         if
           BasisZahlen (ZufallszahlSchleifenwert) < BasisWahrscheinlichkeiten (ZufallszahlSchleifenwert)
         then
            BasisMöglichkeiten (ZufallszahlSchleifenwert) := True;
            
         else
            BasisMöglichkeiten (ZufallszahlSchleifenwert) := False;
         end if;
         
      end loop ZufallszahlenSchleife;
      
      DurchlaufSchleife:
      for DurchlaufSchleifenwert in Boolean'Range loop
         WahrscheinlichkeitSchleife:
         for WahrscheinlichkeitSchleifenwert in BasisWahrscheinlichkeitenArray'Range loop
            
            if
              DurchlaufSchleifenwert = False
              and
                BasisMöglichkeiten (WahrscheinlichkeitSchleifenwert) = False
            then
               null;
                  
            else
               case
                 WelcherGrund
               is
                  when KartengrundDatentypen.Leer_Grund_Enum =>
                     WelcherGrund := WahrscheinlichkeitSchleifenwert;
                        
                  when others =>
                     if
                       BasisZahlen (WahrscheinlichkeitSchleifenwert) > BasisZahlen (WelcherGrund)
                     then
                        WelcherGrund := WahrscheinlichkeitSchleifenwert;
                           
                     else
                        null;
                     end if;
               end case;
            end if;
               
         end loop WahrscheinlichkeitSchleife;
      
         case
           WelcherGrund
         is
            when KartengrundDatentypen.Leer_Grund_Enum =>
               null;
            
            when others =>
               exit DurchlaufSchleife;
         end case;
         
      end loop DurchlaufSchleife;
      
      WelcherGrund := BasisExtraberechnungen (YAchseExtern => YAchseExtern,
                                              XAchseExtern => XAchseExtern,
                                              GrundExtern  => WelcherGrund);
      
      SchreibeKarten.ZweimalGrund (KoordinatenExtern => (0, YAchseExtern, XAchseExtern),
                                   GrundExtern       => WelcherGrund);
      
   end BasisgrundBestimmen;
   
   
   
   procedure ZusatzgrundBestimmen
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv)
   is begin
      
      WelcherGrund := KartengrundDatentypen.Leer_Grund_Enum;
      
      ZufallszahlenSchleife:
      for ZufallszahlSchleifenwert in ZusatzWahrscheinlichkeitenArray'Range loop
         
         ZusatzZahlen (ZufallszahlSchleifenwert) := ZufallsgeneratorenKarten.KartengeneratorZufallswerte;
         
         if
           ZusatzZahlen (ZufallszahlSchleifenwert) < ZusatzWahrscheinlichkeiten (ZufallszahlSchleifenwert)
         then
            ZusatzMöglichkeiten (ZufallszahlSchleifenwert) := True;
            
         else
            ZusatzMöglichkeiten (ZufallszahlSchleifenwert) := False;
         end if;
         
      end loop ZufallszahlenSchleife;
      
      WahrscheinlichkeitSchleife:
      for WahrscheinlichkeitSchleifenwert in ZusatzWahrscheinlichkeitenArray'Range loop
            
         if
           ZusatzMöglichkeiten (WahrscheinlichkeitSchleifenwert) = False
         then
            null;
         
         else
            case
              WelcherGrund
            is
               when KartengrundDatentypen.Leer_Grund_Enum =>
                  WelcherGrund := WahrscheinlichkeitSchleifenwert; 
                        
               when others =>
                  if
                    ZusatzZahlen (WahrscheinlichkeitSchleifenwert) > ZusatzZahlen (WelcherGrund)
                  then
                     WelcherGrund := WahrscheinlichkeitSchleifenwert;
                           
                  else
                     null;
                  end if;
            end case;
         end if;
            
      end loop WahrscheinlichkeitSchleife;
      
      case
        WelcherGrund
      is
         when KartengrundDatentypen.Leer_Grund_Enum =>
            return;
            
         when others =>
            WelcherGrund := ZusatzExtraberechnungen (YAchseExtern => YAchseExtern,
                                                     XAchseExtern => XAchseExtern,
                                                     GrundExtern  => WelcherGrund);
      end case;
            
      case
        WelcherGrund
      is
         when KartengrundDatentypen.Kartengrund_Oberfläche_Zusatz_Enum'Range =>
            SchreibeKarten.AktuellerGrund (KoordinatenExtern => (0, YAchseExtern, XAchseExtern),
                                           GrundExtern       => WelcherGrund);
            
         when others =>
            null;
      end case;
            
   end ZusatzgrundBestimmen;
   
   
   
   function BasisExtraberechnungen
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum)
      return KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum
   is begin
     
      case
        GrundExtern
      is
         when KartengrundDatentypen.Tundra_Enum =>
            return ZusatzberechnungTundra (YAchseExtern => YAchseExtern,
                                           XAchseExtern => XAchseExtern,
                                           GrundExtern  => GrundExtern);
            
         when KartengrundDatentypen.Wüste_Enum =>
            return ZusatzberechnungWüste (YAchseExtern => YAchseExtern,
                                           XAchseExtern => XAchseExtern,
                                           GrundExtern  => GrundExtern);
            
         when KartengrundDatentypen.Hügel_Enum =>
            return ZusatzberechnungHügel (YAchseExtern => YAchseExtern,
                                           XAchseExtern => XAchseExtern,
                                           GrundExtern  => GrundExtern);
            
         when KartengrundDatentypen.Gebirge_Enum =>
            return ZusatzberechnungGebirge (YAchseExtern => YAchseExtern,
                                            XAchseExtern => XAchseExtern,
                                            GrundExtern  => GrundExtern);
            
         when KartengrundDatentypen.Flachland_Enum =>
            return ZusatzberechnungFlachland (YAchseExtern => YAchseExtern,
                                              XAchseExtern => XAchseExtern,
                                              GrundExtern  => GrundExtern);
      end case;
   
   end BasisExtraberechnungen;
   
   
   
   function ZusatzExtraberechnungen
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Zusatz_Enum)
      return KartengrundDatentypen.Kartengrund_Enum
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Wald_Enum =>
            return ZusatzberechnungWald (YAchseExtern => YAchseExtern,
                                         XAchseExtern => XAchseExtern,
                                         GrundExtern  => GrundExtern);
            
         when KartengrundDatentypen.Dschungel_Enum =>
            return ZusatzberechnungDschungel (YAchseExtern => YAchseExtern,
                                              XAchseExtern => XAchseExtern,
                                              GrundExtern  => GrundExtern);
            
         when KartengrundDatentypen.Sumpf_Enum =>
            return ZusatzberechnungSumpf (YAchseExtern => YAchseExtern,
                                          XAchseExtern => XAchseExtern,
                                          GrundExtern  => GrundExtern);
      end case;
   
   end ZusatzExtraberechnungen;
   
   
   
   function ZusatzberechnungTundra
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum)
      return KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum
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
              LeseKarten.AktuellerGrund (KoordinatenExtern => KartenWert) = KartengrundDatentypen.Wüste_Enum
            then
               return KartengrundDatentypen.Wüste_Enum;
                  
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
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum)
      return KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum
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
              LeseKarten.AktuellerGrund (KoordinatenExtern => KartenWert) = KartengrundDatentypen.Eis_Enum
              or
                LeseKarten.AktuellerGrund (KoordinatenExtern => KartenWert) = KartengrundDatentypen.Tundra_Enum
            then
               return KartengrundDatentypen.Tundra_Enum;
                  
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
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum)
      return KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum
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
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum)
      return KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum
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
   
   
   
   function ZusatzberechnungFlachland
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum)
      return KartengrundDatentypen.Kartengrund_Oberfläche_Basis_Enum
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
   
   
   
   function ZusatzberechnungWald
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Zusatz_Enum)
      return KartengrundDatentypen.Kartengrund_Enum
   is begin
      
      BasisGrund := LeseKarten.BasisGrund (KoordinatenExtern => (0, YAchseExtern, XAchseExtern));
      
      if
        BasisGrund = KartengrundDatentypen.Wüste_Enum
      then
         return KartengrundDatentypen.Leer_Grund_Enum;
         
      else
         return GrundExtern;
      end if;
      
   end ZusatzberechnungWald;
   
   
   
   function ZusatzberechnungDschungel
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Zusatz_Enum)
      return KartengrundDatentypen.Kartengrund_Enum
   is begin
      
      BasisGrund := LeseKarten.BasisGrund (KoordinatenExtern => (0, YAchseExtern, XAchseExtern));
      
      if
        BasisGrund = KartengrundDatentypen.Wüste_Enum
        or
          BasisGrund = KartengrundDatentypen.Tundra_Enum
      then
         return KartengrundDatentypen.Leer_Grund_Enum;
         
      else
         return GrundExtern;
      end if;
            
   end ZusatzberechnungDschungel;
   
   
   
   function ZusatzberechnungSumpf
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      GrundExtern : in KartengrundDatentypen.Kartengrund_Oberfläche_Zusatz_Enum)
      return KartengrundDatentypen.Kartengrund_Enum
   is begin
      
      BasisGrund := LeseKarten.BasisGrund (KoordinatenExtern => (0, YAchseExtern, XAchseExtern));
      
      if
        BasisGrund = KartengrundDatentypen.Wüste_Enum
      then
         return KartengrundDatentypen.Leer_Grund_Enum;
         
      else
         return GrundExtern;
      end if;
      
   end ZusatzberechnungSumpf;

end KartengeneratorLandschaft;

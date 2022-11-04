pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen; use KartengrundDatentypen;
with SystemDatentypen; use SystemDatentypen;
with LadezeitenDatentypen;
with KartenKonstanten;

with SchreibeWeltkarte;
with LeseWeltkarte;

with ZufallsgeneratorenKartenLogik;
with KartenkoordinatenberechnungssystemLogik;
with KartengeneratorVariablenLogik;
with LadezeitenLogik;

package body KartengeneratorLandschaftLogik is

   procedure GenerierungLandschaft
   is begin
      
      Kartenzeitwert := (KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.YAchse + (100 - 1)) / 100;
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.YAchse .. KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.XAchse .. KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.XAchse loop
            
            case
              LeseWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, YAchseSchleifenwert, XAchseSchleifenwert))
            is
               when KartengrundDatentypen.Flachland_Enum =>
                  BasisgrundBestimmen (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, YAchseSchleifenwert, XAchseSchleifenwert));

               when others =>
                  null;
            end case;
            
            case
              LeseWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, YAchseSchleifenwert, XAchseSchleifenwert))
            is
               when KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum =>
                  ZusatzgrundBestimmen (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, YAchseSchleifenwert, XAchseSchleifenwert));

               when others =>
                  null;
            end case;
            
         end loop XAchseSchleife;
            
         case
           YAchseSchleifenwert mod Kartenzeitwert
         is
            when 0 =>
               LadezeitenLogik.FortschrittSpielweltSchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Landschaft_Enum);
               
            when others =>
               null;
         end case;
         
      end loop YAchseSchleife;
      
   end GenerierungLandschaft;
   
   
   
   procedure BasisgrundBestimmen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord)
   is begin
      
      Basisgrund := KartengrundDatentypen.Leer_Basisgrund_Enum;
      
      ZufallszahlenSchleife:
      for ZufallszahlSchleifenwert in BasisWahrscheinlichkeitenArray'Range loop
         
         BasisZahlen (ZufallszahlSchleifenwert) := ZufallsgeneratorenKartenLogik.KartengeneratorZufallswerte;
         
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
                 Basisgrund
               is
                  when KartengrundDatentypen.Leer_Basisgrund_Enum =>
                     Basisgrund := WahrscheinlichkeitSchleifenwert;
                        
                  when others =>
                     if
                       BasisZahlen (WahrscheinlichkeitSchleifenwert) > BasisZahlen (Basisgrund)
                     then
                        Basisgrund := WahrscheinlichkeitSchleifenwert;
                        
                     elsif
                       BasisZahlen (WahrscheinlichkeitSchleifenwert) = BasisZahlen (Basisgrund)
                       and
                         ZufallsgeneratorenKartenLogik.KartengeneratorBoolean = True
                     then
                        Basisgrund := WahrscheinlichkeitSchleifenwert;
                           
                     else
                        null;
                     end if;
               end case;
            end if;
               
         end loop WahrscheinlichkeitSchleife;
      
         case
           Basisgrund
         is
            when KartengrundDatentypen.Leer_Basisgrund_Enum =>
               null;
            
            when others =>
               exit DurchlaufSchleife;
         end case;
         
      end loop DurchlaufSchleife;
      
      Basisgrund := BasisExtraberechnungen (KoordinatenExtern => KoordinatenExtern,
                                            GrundExtern       => Basisgrund);
      
      SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse),
                                    GrundExtern       => Basisgrund);
      
   end BasisgrundBestimmen;
   
   
   
   procedure ZusatzgrundBestimmen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord)
   is begin
      
      Zusatzgrund := KartengrundDatentypen.Leer_Zusatzgrund_Enum;
      
      ZufallszahlenSchleife:
      for ZufallszahlSchleifenwert in ZusatzWahrscheinlichkeitenArray'Range loop
         
         ZusatzZahlen (ZufallszahlSchleifenwert) := ZufallsgeneratorenKartenLogik.KartengeneratorZufallswerte;
         
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
              Zusatzgrund
            is
               when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
                  Zusatzgrund := WahrscheinlichkeitSchleifenwert; 
                        
               when others =>
                  if
                    ZusatzZahlen (WahrscheinlichkeitSchleifenwert) > ZusatzZahlen (Zusatzgrund)
                  then
                     Zusatzgrund := WahrscheinlichkeitSchleifenwert;
                        
                  elsif
                    ZusatzZahlen (WahrscheinlichkeitSchleifenwert) = ZusatzZahlen (Zusatzgrund)
                    and
                      ZufallsgeneratorenKartenLogik.KartengeneratorBoolean = True
                  then
                     Zusatzgrund := WahrscheinlichkeitSchleifenwert;
                           
                  else
                     null;
                  end if;
            end case;
         end if;
            
      end loop WahrscheinlichkeitSchleife;
      
      case
        Zusatzgrund
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            return;
            
         when others =>
            Zusatzgrund := ZusatzExtraberechnungen (KoordinatenExtern => KoordinatenExtern,
                                                    GrundExtern       => Zusatzgrund);
      end case;
            
      case
        Zusatzgrund
      is
         when KartengrundDatentypen.Zusatzgrund_Oberfläche_Enum'Range =>
            SchreibeWeltkarte.Zusatzgrund (KoordinatenExtern => (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse),
                                           GrundExtern       => Zusatzgrund);
            
         when others =>
            null;
      end case;
            
   end ZusatzgrundBestimmen;
   
   
   
   function BasisExtraberechnungen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum)
      return KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum
   is begin
     
      case
        GrundExtern
      is
         when KartengrundDatentypen.Tundra_Enum =>
            return ZusatzberechnungTundra (KoordinatenExtern => KoordinatenExtern,
                                           GrundExtern       => GrundExtern);
            
         when KartengrundDatentypen.Wüste_Enum =>
            return ZusatzberechnungWüste (KoordinatenExtern => KoordinatenExtern,
                                           GrundExtern       => GrundExtern);
            
         when KartengrundDatentypen.Hügel_Enum =>
            return ZusatzberechnungHügel (KoordinatenExtern => KoordinatenExtern,
                                           GrundExtern       => GrundExtern);
            
         when KartengrundDatentypen.Gebirge_Enum =>
            return ZusatzberechnungGebirge (KoordinatenExtern => KoordinatenExtern,
                                            GrundExtern       => GrundExtern);
            
         when KartengrundDatentypen.Flachland_Enum =>
            return ZusatzberechnungFlachland (KoordinatenExtern => KoordinatenExtern,
                                              GrundExtern       => GrundExtern);
      end case;
   
   end BasisExtraberechnungen;
   
   
   
   function ZusatzExtraberechnungen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Zusatzgrund_Oberfläche_Enum)
      return KartengrundDatentypen.Zusatzgrund_Enum
   is begin
      
      case
        GrundExtern
      is
         when KartengrundDatentypen.Wald_Enum =>
            return ZusatzberechnungWald (KoordinatenExtern => KoordinatenExtern,
                                         GrundExtern       => GrundExtern);
            
         when KartengrundDatentypen.Dschungel_Enum =>
            return ZusatzberechnungDschungel (KoordinatenExtern => KoordinatenExtern,
                                              GrundExtern       => GrundExtern);
            
         when KartengrundDatentypen.Sumpf_Enum =>
            return ZusatzberechnungSumpf (KoordinatenExtern => KoordinatenExtern,
                                          GrundExtern       => GrundExtern);
      end case;
   
   end ZusatzExtraberechnungen;
   
   
   
   function ZusatzberechnungTundra
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum)
      return KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
            
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse),
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                      LogikGrafikExtern => True);
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              LeseWeltkarte.Basisgrund (KoordinatenExtern => KartenWert) = KartengrundDatentypen.Wüste_Enum
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
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum)
      return KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
            
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse),
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                      LogikGrafikExtern => True);
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              LeseWeltkarte.Basisgrund (KoordinatenExtern => KartenWert) = KartengrundDatentypen.Eis_Enum
              or
                LeseWeltkarte.Basisgrund (KoordinatenExtern => KartenWert) = KartengrundDatentypen.Tundra_Enum
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
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum)
      return KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum
   is begin
      
      if
        KoordinatenExtern.YAchse = KoordinatenExtern.XAchse
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungHügel;
   
   
   
   function ZusatzberechnungGebirge
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum)
      return KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum
   is begin
      
      if
        KoordinatenExtern.YAchse = KoordinatenExtern.XAchse
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungGebirge;
   
   
   
   function ZusatzberechnungFlachland
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum)
      return KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum
   is begin
         
      if
        KoordinatenExtern.YAchse = KoordinatenExtern.XAchse
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungFlachland;
   
   
   
   function ZusatzberechnungWald
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Zusatzgrund_Oberfläche_Enum)
      return KartengrundDatentypen.Zusatzgrund_Enum
   is begin
      
      Basisgrund := LeseWeltkarte.Basisgrund (KoordinatenExtern => (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse));
      
      if
        Basisgrund = KartengrundDatentypen.Wüste_Enum
      then
         return KartengrundDatentypen.Leer_Zusatzgrund_Enum;
         
      else
         return GrundExtern;
      end if;
      
   end ZusatzberechnungWald;
   
   
   
   function ZusatzberechnungDschungel
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Zusatzgrund_Oberfläche_Enum)
      return KartengrundDatentypen.Zusatzgrund_Enum
   is begin
      
      Basisgrund := LeseWeltkarte.Basisgrund (KoordinatenExtern => (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse));
      
      if
        Basisgrund = KartengrundDatentypen.Wüste_Enum
        or
          Basisgrund = KartengrundDatentypen.Tundra_Enum
      then
         return KartengrundDatentypen.Leer_Zusatzgrund_Enum;
         
      else
         return GrundExtern;
      end if;
            
   end ZusatzberechnungDschungel;
   
   
   
   function ZusatzberechnungSumpf
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldVorhandenRecord;
      GrundExtern : in KartengrundDatentypen.Zusatzgrund_Oberfläche_Enum)
      return KartengrundDatentypen.Zusatzgrund_Enum
   is begin
      
      Basisgrund := LeseWeltkarte.Basisgrund (KoordinatenExtern => (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse));
      
      if
        Basisgrund = KartengrundDatentypen.Wüste_Enum
      then
         return KartengrundDatentypen.Leer_Zusatzgrund_Enum;
         
      else
         return GrundExtern;
      end if;
      
   end ZusatzberechnungSumpf;

end KartengeneratorLandschaftLogik;

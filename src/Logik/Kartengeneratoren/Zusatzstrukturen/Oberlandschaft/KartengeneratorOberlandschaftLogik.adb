with ZufallsgeneratorenHTSEB;

with LadezeitenDatentypen;
with KartenKonstanten;
with SystemDatentypen;

with LeseWeltkarte;

with KartenkoordinatenberechnungssystemLogik;
with KartengeneratorVariablenLogik;
with LadezeitenLogik;
with Basisgrundplatzierungssystem;
with KartengeneratorZusatzlandschaftLogik;

package body KartengeneratorOberlandschaftLogik is

   procedure Landschaft
     (LadezeitbasisExtern : in Float)
   is begin
      
      Schleifenbereiche := KartengeneratorVariablenLogik.PolfreierBereichLesen;
      
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in Schleifenbereiche.MinimaleSenkrechte .. Schleifenbereiche.MaximaleSenkrechte loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in Schleifenbereiche.MinimaleWaagerechte .. Schleifenbereiche.MaximaleWaagerechte loop
            
            case
              LeseWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert))
            is
               when KartenbasisgrundDatentypen.Grasland_Enum =>
                  BasisgrundBestimmen (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert));

               when others =>
                  null;
            end case;
            
            case
              LeseWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert))
            is
               when KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum'Range | KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Wasser_Enum'Range =>
                  KartengeneratorZusatzlandschaftLogik.ZusatzgrundBestimmen (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert));

               when others =>
                  null;
            end case;
            
         end loop WaagerechteSchleife;
         
         LadezeitenLogik.KartengeneratorSchreiben (BerechnungszeitExtern => LadezeitenDatentypen.Generiere_Zusatzstrukturen_Enum,
                                                   ZeitExtern            => LadezeitbasisExtern);
         
      end loop SenkrechteSchleife;
      
   end Landschaft;
   
   
   
   procedure BasisgrundBestimmen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord)
   is begin
      
      Temperatur := KartengeneratorVariablenLogik.KartentemperaturLesen;
      
      GezogeneZahl := ZufallsgeneratorenHTSEB.Hunderterbereich;
      
      BasisgrundSchleife:
      for BasisgrundSchleifenwert in Grundwahrscheinlichkeiten'Range (2) loop
         
         if
           GezogeneZahl in Grundwahrscheinlichkeiten (Temperatur, BasisgrundSchleifenwert).Anfangswahrscheinlichkeit .. Grundwahrscheinlichkeiten (Temperatur, BasisgrundSchleifenwert).Endwahrscheinlichkeit
         then
            WelcherGrund := BasisgrundSchleifenwert;
            exit BasisgrundSchleife;
            
         else
            null;
         end if;
         
      end loop BasisgrundSchleife;
         
      Basisgrund := Zusatzberechnungen (KoordinatenExtern => KoordinatenExtern,
                                        GrundExtern       => ZahlenNachBasisgrund (WelcherGrund));
      
      Basisgrundplatzierungssystem.Basisgrundplatzierung (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                                          BasisgrundExtern  => Basisgrund);
      
   end BasisgrundBestimmen;
   
   
   
   function Zusatzberechnungen
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum)
      return KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum
   is begin
     
      case
        GrundExtern
      is
         when KartenbasisgrundDatentypen.Basisgrund_Arktisch_Enum'Range =>
            return Arktisch (KoordinatenExtern => KoordinatenExtern,
                             GrundExtern       => GrundExtern);
            
         when KartenbasisgrundDatentypen.Basisgrund_Tundra_Enum'Range =>
            return ZusatzberechnungTundra (KoordinatenExtern => KoordinatenExtern,
                                           GrundExtern       => GrundExtern);
            
         when KartenbasisgrundDatentypen.Basisgrund_Grasland_Enum'Range =>
            return ZusatzberechnungGrasland (KoordinatenExtern => KoordinatenExtern,
                                             GrundExtern       => GrundExtern);
            
         when KartenbasisgrundDatentypen.Basisgrund_Steppe_Enum'Range =>
            return ZusatzberechnungGrasland (KoordinatenExtern => KoordinatenExtern,
                                             GrundExtern       => GrundExtern);
            
         when KartenbasisgrundDatentypen.Basisgrund_Savanne_Enum'Range =>
            return ZusatzberechnungWüste (KoordinatenExtern => KoordinatenExtern,
                                           GrundExtern       => GrundExtern);
            
         when KartenbasisgrundDatentypen.Basisgrund_Wüste_Enum'Range =>
            return ZusatzberechnungWüste (KoordinatenExtern => KoordinatenExtern,
                                           GrundExtern       => GrundExtern);
                        
         when KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum'Range =>
            return ZusatzberechnungHügel (KoordinatenExtern => KoordinatenExtern,
                                           GrundExtern       => GrundExtern);
            
         when KartenbasisgrundDatentypen.Basisgrund_Gebirge_Enum'Range =>
            return ZusatzberechnungGebirge (KoordinatenExtern => KoordinatenExtern,
                                            GrundExtern       => GrundExtern);
      end case;
   
   end Zusatzberechnungen;
   
   
   
   function Arktisch
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum)
      return KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum
   is
      use type KartenbasisgrundDatentypen.Basisgrund_Enum;
   begin
      
      case
        KartengeneratorVariablenLogik.KartentemperaturLesen
      is
         when KartenartDatentypen.Eiszeit_Enum =>
            return GrundExtern;
            
         when others =>
            GrundÄnderungswert := 0;
      end case;
      
      -- A A A
      -- A X
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in KartenDatentypen.SenkrechteUmgebungEins'Range loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in KartenDatentypen.WaagerechteKartengeneratorumgebung'Range loop
            
            if
              SenkrechteSchleifenwert = 0
              and
                WaagerechteSchleifenwert = 0
            then
               exit SenkrechteSchleife;
               
            else
               KartenWert := KartenkoordinatenberechnungssystemLogik.Koordinatenberechnung (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                                                                            ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                            TaskExtern        => SystemDatentypen.Logik_Task_Enum);
            end if;
            
            if
              KartenWert.Waagerechte = KartenKonstanten.LeerWaagerechte
            then
               null;
                  
            else
               case
                 LeseWeltkarte.Basisgrund (KoordinatenExtern => KartenWert)
               is
                  when KartenbasisgrundDatentypen.Wüste_Enum =>
                     GrundÄnderungswert := GrundÄnderungswert + 2;
                     
                  when KartenbasisgrundDatentypen.Savanne_Enum =>
                     GrundÄnderungswert := GrundÄnderungswert + 1;
                     
                  when KartenbasisgrundDatentypen.Tundra_Enum =>
                     GrundÄnderungswert := GrundÄnderungswert - 1;
                     
                  when KartenbasisgrundDatentypen.Arktisch_Enum =>
                     GrundÄnderungswert := GrundÄnderungswert - 2;
                     
                  when others =>
                     null;
               end case;
            end if;
            
         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;
      
      case
        KartengeneratorVariablenLogik.KartentemperaturLesen
      is
         when KartenartDatentypen.Eiszeit_Enum =>
            null;
            
         when KartenartDatentypen.Kalt_Enum =>
            if
              GrundÄnderungswert >= 8
            then
               return KartenbasisgrundDatentypen.Savanne_Enum;
               
            elsif
              GrundÄnderungswert >= 6
              and
                ZufallsgeneratorenHTSEB.Münzwurf
            then
               return KartenbasisgrundDatentypen.Grasland_Enum;
               
            elsif
              GrundÄnderungswert >= 6
            then
               return KartenbasisgrundDatentypen.Steppe_Enum;
               
            elsif
              GrundÄnderungswert >= 4
            then
               return KartenbasisgrundDatentypen.Tundra_Enum;
               
            else
               null;
            end if;
            
         when KartenartDatentypen.Gemäßigt_Enum =>
            null;
            
         when KartenartDatentypen.Heiß_Enum =>
            null;
            
         when KartenartDatentypen.Warmzeit_Enum =>
            null;
      end case;
      
      return GrundExtern;
      
   end Arktisch;
   
   
   
   function ZusatzberechnungTundra
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum)
   return KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum
   is
      use type KartenbasisgrundDatentypen.Basisgrund_Enum;
   begin
      
      -- A A A
      -- A X
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in KartenDatentypen.SenkrechteUmgebungEins'Range loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in KartenDatentypen.WaagerechteKartengeneratorumgebung'Range loop
            
            KartenWert := KartenkoordinatenberechnungssystemLogik.Koordinatenberechnung (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                                                                         ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                         TaskExtern        => SystemDatentypen.Logik_Task_Enum);
            
            if
              KartenWert.Waagerechte = KartenKonstanten.LeerWaagerechte
            then
               null;
               
            elsif
              LeseWeltkarte.Basisgrund (KoordinatenExtern => KartenWert) = KartenbasisgrundDatentypen.Wüste_Enum
            then
               return KartenbasisgrundDatentypen.Wüste_Enum;
                  
            else
               null;
            end if;
            
         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;
      
      return GrundExtern;
      
   end ZusatzberechnungTundra;
   
   
   
   function ZusatzberechnungWüste
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum)
   return KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum
   is
      use type KartenbasisgrundDatentypen.Basisgrund_Enum;
   begin
      
      -- A A A
      -- A X
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in KartenDatentypen.SenkrechteUmgebungEins'Range loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in KartenDatentypen.WaagerechteKartengeneratorumgebung'Range loop
            
            KartenWert := KartenkoordinatenberechnungssystemLogik.Koordinatenberechnung (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                                                                         ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                         TaskExtern        => SystemDatentypen.Logik_Task_Enum);
            
            if
              KartenWert.Waagerechte = KartenKonstanten.LeerWaagerechte
            then
               null;
               
            elsif
              LeseWeltkarte.Basisgrund (KoordinatenExtern => KartenWert) = KartenbasisgrundDatentypen.Eis_Enum
              or
                LeseWeltkarte.Basisgrund (KoordinatenExtern => KartenWert) = KartenbasisgrundDatentypen.Tundra_Enum
            then
               return KartenbasisgrundDatentypen.Tundra_Enum;
                  
            else
               null;
            end if;
            
         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;
      
      return GrundExtern;
      
   end ZusatzberechnungWüste;
   
   
   
   function ZusatzberechnungHügel
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Hügel_Enum)
   return KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum
   is begin
      
      if
        KoordinatenExtern.Senkrechte = KartenDatentypen.SenkrechteBasis (KoordinatenExtern.Waagerechte)
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungHügel;
   
   
   
   function ZusatzberechnungGebirge
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Gebirge_Enum)
   return KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum
   is begin
      
      if
        KoordinatenExtern.Senkrechte = KartenDatentypen.SenkrechteBasis (KoordinatenExtern.Waagerechte)
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungGebirge;
   
   
   
   function ZusatzberechnungGrasland
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum)
   return KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum
   is begin
         
      if
        KoordinatenExtern.Senkrechte = KartenDatentypen.SenkrechteBasis (KoordinatenExtern.Waagerechte)
      then
         null;
         
      else
         null;
      end if;
      
      return GrundExtern;
      
   end ZusatzberechnungGrasland;

end KartengeneratorOberlandschaftLogik;

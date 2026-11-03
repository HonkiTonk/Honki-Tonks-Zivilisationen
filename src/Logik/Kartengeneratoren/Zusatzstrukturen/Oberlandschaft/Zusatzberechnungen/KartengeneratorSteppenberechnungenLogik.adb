with ZufallsgeneratorenHTSEB;

with KartenKonstanten;
with SystemDatentypen;

with LeseWeltkarte;

with KartenkoordinatenberechnungssystemLogik;

package body KartengeneratorSteppenberechnungenLogik is
   
   function Steppe
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum;
      TemperaturExtern : in KartenartDatentypen.Kartentemperatur_Enum)
      return KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum
   is begin
      
      case
        TemperaturExtern
      is
         when KartenartDatentypen.Eiszeit_Enum =>
            return GrundExtern;
            
         when others =>
            GrundÄnderungswert := 0;
      end case;
      
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in KartenDatentypen.SenkrechteUmgebungEins'Range loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in KartenDatentypen.WaagerechteUmgebungEins'Range loop
            
            if
              SenkrechteSchleifenwert = 0
              and
                WaagerechteSchleifenwert = 0
            then
               null;
               
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
                  when KartenbasisgrundDatentypen.Basisgrund_Wüste_Enum'Range =>
                     GrundÄnderungswert := GrundÄnderungswert + 2;
                     
                  when KartenbasisgrundDatentypen.Basisgrund_Savanne_Enum'Range =>
                     GrundÄnderungswert := GrundÄnderungswert + 1;
                     
                  when KartenbasisgrundDatentypen.Basisgrund_Tundra_Enum'Range =>
                     GrundÄnderungswert := GrundÄnderungswert - 1;
                     
                  when KartenbasisgrundDatentypen.Basisgrund_Arktis_Enum'Range =>
                     GrundÄnderungswert := GrundÄnderungswert - 2;
                     
                  when KartenbasisgrundDatentypen.Basisgrund_Eis_Enum'Range =>
                     GrundÄnderungswert := GrundÄnderungswert - 3;
                     
                  when others =>
                     null;
               end case;
            end if;
            
         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;
      
      return Temperaturberechnugnen (TemperaturExtern    => TemperaturExtern,
                                     GrundExtern         => GrundExtern,
                                     ÄnderungswertExtern => GrundÄnderungswert);
      
   end Steppe;
   
   
   
   function Temperaturberechnugnen
     (TemperaturExtern : in KartenartDatentypen.Kartentemperatur_Enum;
      GrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum;
      ÄnderungswertExtern : in Integer)
      return KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum
   is begin
      
      case
        TemperaturExtern
      is
         when KartenartDatentypen.Eiszeit_Enum =>
            null;
            
         when KartenartDatentypen.Kalt_Enum =>
            if
              ÄnderungswertExtern >= 8
            then
               return KartenbasisgrundDatentypen.Savanne_Enum;
               
            elsif
              ÄnderungswertExtern >= 6
              and
                ZufallsgeneratorenHTSEB.Münzwurf = False
            then
               return KartenbasisgrundDatentypen.Steppe_Enum;
               
            elsif
              ÄnderungswertExtern >= 6
            then
               return KartenbasisgrundDatentypen.Grasland_Enum;
               
            elsif
              ÄnderungswertExtern >= 4
            then
               return KartenbasisgrundDatentypen.Tundra_Enum;
               
            else
               null;
            end if;
            
         when KartenartDatentypen.Gemäßigt_Enum =>
            if
              ÄnderungswertExtern >= 6
            then
               return KartenbasisgrundDatentypen.Savanne_Enum;
               
            elsif
              ÄnderungswertExtern >= 4
              and
                ZufallsgeneratorenHTSEB.Münzwurf = False
            then
               return KartenbasisgrundDatentypen.Steppe_Enum;
               
            elsif
              ÄnderungswertExtern >= 4
            then
               return KartenbasisgrundDatentypen.Grasland_Enum;
               
            elsif
              ÄnderungswertExtern >= 2
            then
               return KartenbasisgrundDatentypen.Tundra_Enum;
               
            else
               null;
            end if;
            
         when KartenartDatentypen.Heiß_Enum =>
            if
              ÄnderungswertExtern >= 4
            then
               return KartenbasisgrundDatentypen.Savanne_Enum;
               
            elsif
              ÄnderungswertExtern >= 2
              and
                ZufallsgeneratorenHTSEB.Münzwurf = False
            then
               return KartenbasisgrundDatentypen.Steppe_Enum;
               
            elsif
              ÄnderungswertExtern >= 2
            then
               return KartenbasisgrundDatentypen.Grasland_Enum;
               
            elsif
              ÄnderungswertExtern >= 0
            then
               return KartenbasisgrundDatentypen.Tundra_Enum;
               
            else
               null;
            end if;
            
         when KartenartDatentypen.Warmzeit_Enum =>
            if
              ÄnderungswertExtern >= 2
            then
               return KartenbasisgrundDatentypen.Savanne_Enum;
               
            elsif
              ÄnderungswertExtern >= 0
              and
                ZufallsgeneratorenHTSEB.Münzwurf = False
            then
               return KartenbasisgrundDatentypen.Steppe_Enum;
               
            elsif
              ÄnderungswertExtern >= 0
            then
               return KartenbasisgrundDatentypen.Grasland_Enum;
               
            elsif
              ÄnderungswertExtern >= -2
            then
               return KartenbasisgrundDatentypen.Tundra_Enum;
               
            else
               null;
            end if;
      end case;
      
      return GrundExtern;
      
   end Temperaturberechnugnen;

end KartengeneratorSteppenberechnungenLogik;

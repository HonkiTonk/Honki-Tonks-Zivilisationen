with KartenKonstanten;
with SystemDatentypen;

with LeseWeltkarte;

with KartenkoordinatenberechnungssystemLogik;

package body KartengeneratorSavannenberechnungenLogik is
   
   function Savanne
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      GrundExtern : in KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum)
      return KartenbasisgrundDatentypen.Basisgrund_Oberfläche_Land_Enum
   is
      use type KartenbasisgrundDatentypen.Basisgrund_Enum;
   begin
      
      NeuerGrund := GrundExtern;
      
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
                  when KartenbasisgrundDatentypen.Basisgrund_Eis_Enum'Range =>
                     return KartenbasisgrundDatentypen.Arktis_Enum;
                     
                  when others =>
                     null;
               end case;
            end if;
            
         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;
      
      return NeuerGrund;
      
   end Savanne;

end KartengeneratorSavannenberechnungenLogik;

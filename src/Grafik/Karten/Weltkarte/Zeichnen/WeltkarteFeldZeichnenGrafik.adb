with GrafikKonstanten;

with LeseWeltkarte;

with KartenspritesZeichnenGrafik;
with EingeleseneTexturenGrafik;
with TexturenfelderVariablenGrafik;

package body WeltkarteFeldZeichnenGrafik is

   procedure BasisgrundZeichnen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      DurchsichtigkeitExtern : in Sf.sfUint8)
   is begin
          
      KartenspritesZeichnenGrafik.KartenfeldZeichnen (TexturAccessExtern     => EingeleseneTexturenGrafik.BasisgrundAccess,
                                                      TexturbereichExtern    => TexturenfelderVariablenGrafik.BasisgrundRechteck (BasisgrundExtern => LeseWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern)),
                                                      PositionExtern         => PositionExtern,
                                                      DurchsichtigkeitExtern => DurchsichtigkeitExtern);
      
   end BasisgrundZeichnen;
   
   
   
   procedure ZusatzgrundZeichnen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      DurchsichtigkeitExtern : in Sf.sfUint8)
   is begin
      
      Zusatzgrund := LeseWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern);
        
      case
        Zusatzgrund
      is
         when KartenzusatzgrundDatentypen.Leer_Zusatzgrund_Enum =>
            null;
            
         when others =>
            KartenspritesZeichnenGrafik.KartenfeldZeichnen (TexturAccessExtern     => EingeleseneTexturenGrafik.ZusatzgrundAccess,
                                                            TexturbereichExtern    => TexturenfelderVariablenGrafik.ZusatzgrundRechteck (ZusatzgrundExtern => Zusatzgrund),
                                                            PositionExtern         => PositionExtern,
                                                            DurchsichtigkeitExtern => DurchsichtigkeitExtern);
      end case;
      
   end ZusatzgrundZeichnen;
   
   
   
   procedure FlussZeichnen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      KartenfeldFluss := LeseWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenfeldFluss
      is
         when KartenfluesseDatentypen.Leer_Fluss_Enum =>
            null;
            
         when others =>
            KartenspritesZeichnenGrafik.KartenfeldZeichnen (TexturAccessExtern     => EingeleseneTexturenGrafik.FlussAccess,
                                                            TexturbereichExtern    => TexturenfelderVariablenGrafik.FlussRechteck (FlussExtern => KartenfeldFluss),
                                                            PositionExtern         => PositionExtern,
                                                            DurchsichtigkeitExtern => GrafikKonstanten.Undurchsichtig);
      end case;
      
   end FlussZeichnen;
   
   
   
   procedure RessourceZeichnen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      KartenfeldRessource := LeseWeltkarte.Ressource (KoordinatenExtern => KoordinatenExtern);
      
      case
        KartenfeldRessource
      is
         when KartenressourcenDatentypen.Leer_Ressource_Enum =>
            null;
            
         when others =>
            KartenspritesZeichnenGrafik.KartenfeldZeichnen (TexturAccessExtern     => EingeleseneTexturenGrafik.RessourcenAccess,
                                                            TexturbereichExtern    => TexturenfelderVariablenGrafik.RessourcenRechteck (RessourceExtern => KartenfeldRessource),
                                                            PositionExtern         => PositionExtern,
                                                            DurchsichtigkeitExtern => GrafikKonstanten.Undurchsichtig);
      end case;
      
   end RessourceZeichnen;

end WeltkarteFeldZeichnenGrafik;

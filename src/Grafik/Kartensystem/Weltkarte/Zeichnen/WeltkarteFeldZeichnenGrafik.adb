with GrafikKonstanten;
with KartenrohstoffeDatentypen;

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
   
   
   
   procedure RohstoffZeichnen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Rohstoffe := LeseWeltkarte.AlleRohstoffe (KoordinatenExtern => KoordinatenExtern);
      
      case
        Rohstoffe (Rohstoffe'First)
      is
         when KartenrohstoffeDatentypen.Leer_Rohstoffe_Enum =>
            return;
            
         when others =>
            null;
      end case;
      
      RohstoffeSchleife:
      for RohstoffeSchleifenwert in Rohstoffe'Range loop
               
         KartenspritesZeichnenGrafik.KartenfeldZeichnen (TexturAccessExtern     => EingeleseneTexturenGrafik.RohstoffeAccess,
                                                         TexturbereichExtern    => TexturenfelderVariablenGrafik.RohstoffeRechteck (RohstoffeExtern => Rohstoffe (RohstoffeSchleifenwert)),
                                                         PositionExtern         => PositionExtern,
                                                         DurchsichtigkeitExtern => GrafikKonstanten.Undurchsichtig);
         
      end loop RohstoffeSchleife;
      
   end RohstoffZeichnen;

end WeltkarteFeldZeichnenGrafik;

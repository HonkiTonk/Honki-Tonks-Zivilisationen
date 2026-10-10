with GrafikKonstanten;
with KartenrohstoffeDatentypen;
with KartenverbesserungDatentypen;

with LeseWeltkarte;

with KartenspritesZeichnenGrafik;
with EingeleseneTexturenGrafik;
with TexturenfelderVariablenGrafik;
with SichtweitenGrafik;

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
   
   
   
   procedure RohstoffeZeichnen
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
            Kartenfeld := SichtweitenGrafik.Kartenfeldfläche;
      end case;
      
      RohstoffeSchleife:
      for RohstoffeSchleifenwert in Rohstoffe'Range loop
               
         case
           RohstoffeSchleifenwert
         is
            when KartenrohstoffeDatentypen.Rohstoff_Eins_Enum =>
               Rohstoffposition := PositionExtern;
               
            when KartenrohstoffeDatentypen.Rohstoff_Zwei_Enum =>
               Rohstoffposition.x := PositionExtern.x + Kartenfeld.x / 2.00;
               Rohstoffposition.y := PositionExtern.y;
               
            when KartenrohstoffeDatentypen.Rohstoff_Drei_Enum =>
               Rohstoffposition.x := PositionExtern.x;
               Rohstoffposition.y := PositionExtern.y + Kartenfeld.y / 2.00;
               
            when KartenrohstoffeDatentypen.Rohstoffe_Vier_Enum =>
               Rohstoffposition.x := PositionExtern.x + Kartenfeld.x / 2.00;
               Rohstoffposition.y := PositionExtern.y + Kartenfeld.y / 2.00;
         end case;
                  
         KartenspritesZeichnenGrafik.RohstoffeVerbesserungenZeichnen (TexturAccessExtern     => EingeleseneTexturenGrafik.RohstoffeAccess,
                                                                      TexturbereichExtern    => TexturenfelderVariablenGrafik.RohstoffeRechteck (RohstoffeExtern => Rohstoffe (RohstoffeSchleifenwert)),
                                                                      PositionExtern         => Rohstoffposition,
                                                                      DurchsichtigkeitExtern => GrafikKonstanten.Undurchsichtig);
         
      end loop RohstoffeSchleife;
      
   end RohstoffeZeichnen;
   
   
   
   procedure VerbesserungenZeichnen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is
      use type KartenverbesserungDatentypen.Verbesserungen_Enum;
   begin
      
      Verbesserungen := LeseWeltkarte.AlleVerbesserungen (KoordinatenExtern => KoordinatenExtern);
            
      VerbesserungenSchleife:
      for VerbesserungenSchleifenwert in Verbesserungen'Range loop
         
         if
           Verbesserungen (VerbesserungenSchleifenwert) = KartenverbesserungDatentypen.Leer_Verbesserungen_Enum
         then
            null;
            
         else
            case
              VerbesserungenSchleifenwert
            is
               when KartenverbesserungDatentypen.Verbesserung_Eins_Enum =>
                  Verbesserungsposition := PositionExtern;
               
               when KartenverbesserungDatentypen.Verbesserung_Zwei_Enum =>
                  Verbesserungsposition.x := PositionExtern.x + Kartenfeld.x / 2.00;
                  Verbesserungsposition.y := PositionExtern.y;
               
               when KartenverbesserungDatentypen.Verbesserung_Drei_Enum =>
                  Verbesserungsposition.x := PositionExtern.x;
                  Verbesserungsposition.y := PositionExtern.y + Kartenfeld.y / 2.00;
               
               when KartenverbesserungDatentypen.Verbesserung_Vier_Enum =>
                  Verbesserungsposition.x := PositionExtern.x + Kartenfeld.x / 2.00;
                  Verbesserungsposition.y := PositionExtern.y + Kartenfeld.y / 2.00;
            end case;
               
            KartenspritesZeichnenGrafik.RohstoffeVerbesserungenZeichnen (TexturAccessExtern     => EingeleseneTexturenGrafik.VerbesserungenAccess,
                                                                         TexturbereichExtern    => TexturenfelderVariablenGrafik.VerbesserungRechteck (VerbesserungExtern => Verbesserungen (VerbesserungenSchleifenwert)),
                                                                         PositionExtern         => Verbesserungsposition,
                                                                         DurchsichtigkeitExtern => GrafikKonstanten.Undurchsichtig);
            null;
         end if;
         
      end loop VerbesserungenSchleife;
      
   end VerbesserungenZeichnen;

end WeltkarteFeldZeichnenGrafik;

pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen; use KartengrundDatentypen;
with KartenKonstanten;

with LeseKarten;

with Kartenkoordinatenberechnungssystem;
with ZufallsgeneratorenKarten;
with KartengeneratorVariablen;
with Flussplatzierungssystem;

package body KartengeneratorFluss is
   
   procedure AufteilungFlussgenerierung
   is begin
      
      GenerierungFlüsse;
      
   end AufteilungFlussgenerierung;
   
   

   procedure GenerierungFlüsse
   is
   
      task Lavaflüsse;
      task UnterirdischeFlüsse;
      
      task body Lavaflüsse
      is begin
         
         FlussGenerierung (EbeneExtern => -2);
         
      end Lavaflüsse;
      
      task body UnterirdischeFlüsse
      is begin
         
         FlussGenerierung (EbeneExtern => -1);
         
      end UnterirdischeFlüsse;
      
   begin
      
      FlussGenerierung (EbeneExtern => 0);
      
   end GenerierungFlüsse;
   
   
   
   procedure FlussGenerierung
     (EbeneExtern : in KartenDatentypen.EbeneVorhanden)
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.YAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartengeneratorVariablen.SchleifenanfangOhnePolbereich.XAchse .. KartengeneratorVariablen.SchleifenendeOhnePolbereich.XAchse loop
            
            case
              LeseKarten.AktuellerGrund (KoordinatenExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert))
            is
               when KartengrundDatentypen.Kartengrund_Oberfläche_Eiswasser_Enum'Range | KartengrundDatentypen.Kartengrund_Unterfläche_Eiswasser_Enum'Range
                  | KartengrundDatentypen.Kartengrund_Kernfläche_Flüssig_Enum'Range =>
                  null;
                  
               when others =>
                  if
                    FlussumgebungTesten (KoordinatenExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert)) = True
                  then
                     Flussplatzierungssystem.FlussBerechnung (KoordinatenExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert));
                     
                  else
                     null;
                  end if;
            end case;
         
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end FlussGenerierung;
   
   
   
   function FlussumgebungTesten
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
         
      BeliebigerFlusswert (KoordinatenExtern.EAchse) := ZufallsgeneratorenKarten.KartengeneratorZufallswerte;
                  
      if
        BeliebigerFlusswert (KoordinatenExtern.EAchse) <= WahrscheinlichkeitFluss (KoordinatenExtern.EAchse)
      then
         return True;
         
      elsif
        Float (BeliebigerFlusswert (KoordinatenExtern.EAchse)) * FlussumgebungBonus > Float (WahrscheinlichkeitFluss (KoordinatenExtern.EAchse))
      then
         return False;
         
      else
         null;
      end if;
      
      YAchseSchleife:
      for YÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
                  
            KartenWert (KoordinatenExtern.EAchse) := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                                            ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                                                                            LogikGrafikExtern => True);
            
            if
              KartenWert (KoordinatenExtern.EAchse).XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              LeseKarten.Fluss (KoordinatenExtern => KartenWert (KoordinatenExtern.EAchse)) /= KartengrundDatentypen.Leer_Fluss_Enum
            then
               return True;

            else
               null;
            end if;
         
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      return False;
         
   end FlussumgebungTesten;

end KartengeneratorFluss;

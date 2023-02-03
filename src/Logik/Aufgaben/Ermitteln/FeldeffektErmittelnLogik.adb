with AufgabenDatentypen;
with ForschungRecordKonstanten;
with ForschungenDatentypen;
with ForschungKonstanten;

with LeseWeltkarte;
with LeseWichtiges;

with AufgabeFestlegenLogik;

package body FeldeffektErmittelnLogik is

   function FeldeffektErmitteln
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      AnlegenTestenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is
      use type ForschungenDatentypen.ForschungIDNichtMöglich;
   begin
      
      FeldeffektEntfernbar := False;
      
      FeldeffekteSchleife:
      for FeldeffektSchleifenwert in KartenRecords.FeldeffektArray'Range loop
         
         case
           LeseWeltkarte.Effekt (KoordinatenExtern   => KoordinatenExtern,
                                 WelcherEffektExtern => FeldeffektSchleifenwert)
         is
            when True =>
               if
                 ForschungRecordKonstanten.StandardtechnologieEffektentfernung (FeldeffektSchleifenwert, EinheitSpeziesNummerExtern.Spezies) = ForschungKonstanten.ForschungUnmöglich
               then
                  null;
                  
               elsif
                 ForschungRecordKonstanten.StandardtechnologieEffektentfernung (FeldeffektSchleifenwert, EinheitSpeziesNummerExtern.Spezies) = ForschungKonstanten.LeerForschung
                 or else
                   True = LeseWichtiges.Erforscht (SpeziesExtern           => EinheitSpeziesNummerExtern.Spezies,
                                                   WelcheTechnologieExtern => ForschungRecordKonstanten.StandardtechnologieEffektentfernung (FeldeffektSchleifenwert, EinheitSpeziesNummerExtern.Spezies))
               then
                  FeldeffektEntfernbar := True;
                  exit FeldeffekteSchleife;

               else
                  null;
               end if;
               
            when False =>
               null;
         end case;
            
      end loop FeldeffekteSchleife;
      
      case
        FeldeffektEntfernbar
      is
         when False =>
            return False;
            
         when True =>
            null;
      end case;
      
      case
        AnlegenTestenExtern
      is
         when True =>
            AufgabeFestlegenLogik.AufgabeFestlegen (ArbeitExtern               => (AufgabenDatentypen.Feldeffekt_Entfernen_Enum, 5, False),
                                                    EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            
         when False =>
            null;
      end case;
      
      return True;
      
   end FeldeffektErmitteln;

end FeldeffektErmittelnLogik;

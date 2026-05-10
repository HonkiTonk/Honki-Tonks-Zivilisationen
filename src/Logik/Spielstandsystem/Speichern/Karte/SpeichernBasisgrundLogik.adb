with Ada.Exceptions; use Ada.Exceptions;
  
with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with KartenKonstanten;
with KartengrundDatentypen;

with LeseWeltkarte;

package body SpeichernBasisgrundLogik is
   
   -- Muss bei Kartengrund der Rand mitgespeichert werden? Ist der nicht auch so bekannt? äöü
   function Basisgrund
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is begin
      
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.WeltraumKonstante | KartenKonstanten.HimmelKonstante =>
            null;
            
         when KartenKonstanten.OberflächeKonstante =>
            KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                   LeseWeltkarte.Basisgrund (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte)));
            
         when KartenKonstanten.UnterflächeKonstante =>
            KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                   LeseWeltkarte.Basisgrund (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte)));
            
         when KartenKonstanten.PlaneteninneresKonstante =>
            KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                   LeseWeltkarte.Basisgrund (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte)));
      end case;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernKartenbelegungLogik.Basisgrund: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end Basisgrund;

end SpeichernBasisgrundLogik;
